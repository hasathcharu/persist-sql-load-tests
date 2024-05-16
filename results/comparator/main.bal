import ballerina/io;

const MYSQL_DIR = "../MySql";
const MYSQL_PERSIST_Q_DIR = "../MySqlPersistQ";
const PERSIST_SQL_DIR = "../Persist.sql";
const SPRING_BOOT_DIR = "../SpringBoot";
const COMPARISONS_DIR = "../Comparisons";

public function main() returns error? {
    string[30][32] comparisons = [[]];
    foreach int request in 0...5 {
        foreach int pass in 1...5 {
            string[][] persistSql = check io:fileReadCsv(string `${PERSIST_SQL_DIR}/Pass${pass}.csv`);
            string[][] mysql = check io:fileReadCsv(string `${MYSQL_DIR}/Pass${pass}.csv`);
            string[][] mySqlPersistQ = check io:fileReadCsv(string `${MYSQL_PERSIST_Q_DIR}/Pass${pass}.csv`);
            string[][] springBoot = check io:fileReadCsv(string `${SPRING_BOOT_DIR}/Pass${pass}.csv`);
            string[32] comparison = [];
            foreach int property in 0...7 {
                comparison[property*4] = persistSql[request][property];
                comparison[property*4 + 1] = mysql[request][property];
                comparison[property*4 + 2] = mySqlPersistQ[request][property];
                comparison[property*4 + 3] = springBoot[request][property];
            }
            comparisons[(request*5)+(pass-1)] = comparison;
        }
        
    }
    _ = check io:fileWriteCsv(string `${COMPARISONS_DIR}/comparisons.csv`, comparisons);
}
