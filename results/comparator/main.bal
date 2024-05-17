import ballerina/io;

const MYSQL_DIR = "../MySql";
const MYSQL_PERSIST_Q_DIR = "../MySqlPersistQ";
const PERSIST_SQL_DIR = "../Persist.sql";
const SPRING_BOOT_DIR = "../SpringBoot";
const COMPARISONS_DIR = "../comparisons";

public function main() returns error? {
    string[30][32] comparisons = [[]];
    foreach int request in 0...5 {
        foreach int pass in 1...5 {
            string[][] persistSql = check io:fileReadCsv(string `${PERSIST_SQL_DIR}/Pass${pass}.csv`,skipHeaders = 1);
            string[][] mysql = check io:fileReadCsv(string `${MYSQL_DIR}/Pass${pass}.csv`,skipHeaders = 1);
            string[][] mySqlPersistQ = check io:fileReadCsv(string `${MYSQL_PERSIST_Q_DIR}/Pass${pass}.csv`,skipHeaders = 1);
            string[][] springBoot = check io:fileReadCsv(string `${SPRING_BOOT_DIR}/Pass${pass}.csv`,skipHeaders = 1);
            string[32] comparison = [];
            int comparisonIndex = 0;
            foreach int property in 2...10 {
                if property == 6 {
                    // ignore error rate property
                    continue;
                }
                comparison[comparisonIndex*4] = persistSql[request][property];
                comparison[comparisonIndex*4 + 1] = mysql[request][property];
                comparison[comparisonIndex*4 + 2] = mySqlPersistQ[request][property];
                comparison[comparisonIndex*4 + 3] = springBoot[request][property];
                comparisonIndex += 1;
            }
            comparisons[(request*5)+(pass)] = comparison;
        }
        
    }
    _ = check io:fileWriteCsv(string `${COMPARISONS_DIR}/comparisons.csv`, comparisons);
}
