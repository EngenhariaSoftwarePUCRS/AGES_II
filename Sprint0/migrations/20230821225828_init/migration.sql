-- CreateTable
CREATE TABLE `User` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(120) NOT NULL,
    `cpf` CHAR(11) NOT NULL,
    `userTypeId` INTEGER NOT NULL,
    `walletId` INTEGER NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    UNIQUE INDEX `User_cpf_key`(`cpf`),
    UNIQUE INDEX `User_walletId_key`(`walletId`),
    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserType` (
    `userTypeId` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`userTypeId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Wallet` (
    `walletId` INTEGER NOT NULL AUTO_INCREMENT,
    `claps` INTEGER NOT NULL,
    `coins` INTEGER NOT NULL,
    `walletLimit` INTEGER NOT NULL,
    `limitMultiplier` DOUBLE NOT NULL,
    `userId` INTEGER NOT NULL,

    UNIQUE INDEX `Wallet_userId_key`(`userId`),
    PRIMARY KEY (`walletId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction` (
    `transactionId` INTEGER NOT NULL AUTO_INCREMENT,
    `senderId` INTEGER NOT NULL,
    `receiverId` INTEGER NOT NULL,
    `feedbackId` INTEGER NOT NULL,
    `value` DOUBLE NOT NULL,
    `date` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Transaction_feedbackId_key`(`feedbackId`),
    PRIMARY KEY (`transactionId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Feedback` (
    `feedbackId` INTEGER NOT NULL AUTO_INCREMENT,
    `message` VARCHAR(300) NULL,
    `visibility` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`feedbackId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Redeem` (
    `redeemId` INTEGER NOT NULL AUTO_INCREMENT,
    `price` INTEGER NOT NULL,
    `datetime` DATETIME(3) NOT NULL,
    `userId` INTEGER NOT NULL,
    `itemId` INTEGER NOT NULL,

    PRIMARY KEY (`redeemId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Item` (
    `itemId` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(120) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,
    `price` INTEGER NOT NULL,
    `image` VARCHAR(191) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,
    `available` BOOLEAN NOT NULL,

    PRIMARY KEY (`itemId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_userTypeId_fkey` FOREIGN KEY (`userTypeId`) REFERENCES `UserType`(`userTypeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Wallet` ADD CONSTRAINT `Wallet_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_senderId_fkey` FOREIGN KEY (`senderId`) REFERENCES `User`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_receiverId_fkey` FOREIGN KEY (`receiverId`) REFERENCES `User`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_feedbackId_fkey` FOREIGN KEY (`feedbackId`) REFERENCES `Feedback`(`feedbackId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Redeem` ADD CONSTRAINT `Redeem_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Redeem` ADD CONSTRAINT `Redeem_itemId_fkey` FOREIGN KEY (`itemId`) REFERENCES `Item`(`itemId`) ON DELETE RESTRICT ON UPDATE CASCADE;
