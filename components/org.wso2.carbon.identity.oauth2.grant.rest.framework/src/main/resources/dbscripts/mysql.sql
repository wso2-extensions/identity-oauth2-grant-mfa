CREATE TABLE IF NOT EXISTS IDN_REST_AUTH_FLOW (
            FLOW_ID_IDENTIFIER VARCHAR (255) NOT NULL,
            FLOW_ID VARCHAR (255),
            FLOW_ID_STATE VARCHAR (25) DEFAULT 'ACTIVE',
            TIME_GENERATED LONG NOT NULL,
            EXPIRY_TIME LONG NOT NULL,
            IS_AUTH_FLOW_COMPLETED VARCHAR (10) DEFAULT 'FALSE',
            SP_APP_ID INTEGER,
            SP_TENANT_ID INTEGER DEFAULT -1,
            ORG_ID INTEGER DEFAULT 1,
            PRIMARY KEY (FLOW_ID_IDENTIFIER),
            CONSTRAINT FLOW_ID_CONSTRAINT UNIQUE (FLOW_ID),
            FOREIGN KEY (SP_APP_ID) REFERENCES SP_APP(ID) ON DELETE CASCADE
)ENGINE INNODB;

CREATE TABLE IF NOT EXISTS IDN_REST_AUTH_USER (
            ID INTEGER AUTO_INCREMENT,
            USER_TENANT_ID INTEGER NOT NULL,
            USER_ID VARCHAR(255) NOT NULL,
            USERNAME VARCHAR(255) NOT NULL,
            FLOW_ID_IDENTIFIER VARCHAR (255) NOT NULL,
            PRIMARY KEY (ID),
            FOREIGN KEY (FLOW_ID_IDENTIFIER) REFERENCES IDN_REST_AUTH_FLOW(FLOW_ID_IDENTIFIER) ON DELETE CASCADE
)ENGINE INNODB;

CREATE TABLE IF NOT EXISTS IDN_REST_AUTH_AUTHENTICATED_STEPS (
            ID INTEGER AUTO_INCREMENT,
            DATA_KEY INTEGER NOT NULL,
            DATA_VALUE VARCHAR(85) NOT NULL,
            FLOW_ID_IDENTIFIER VARCHAR (255) NOT NULL,
            PRIMARY KEY (ID),
            CONSTRAINT AUTHENTICATED_STEPS_CONSTRAINT UNIQUE (DATA_KEY, DATA_VALUE, FLOW_ID_IDENTIFIER),
            FOREIGN KEY (FLOW_ID_IDENTIFIER) REFERENCES IDN_REST_AUTH_FLOW(FLOW_ID_IDENTIFIER) ON DELETE CASCADE
)ENGINE INNODB;


DELIMITER //

CREATE PROCEDURE DeleteExpiredOrInactiveFlows()
BEGIN
    -- Delete from IDN_REST_AUTH_AUTHENTICATED_STEPS
    DELETE FROM IDN_REST_AUTH_AUTHENTICATED_STEPS
    WHERE FLOW_ID_IDENTIFIER IN (
        SELECT FLOW_ID_IDENTIFIER
        FROM IDN_REST_AUTH_FLOW
        WHERE FLOW_ID_STATE = 'EXPIRED' OR FLOW_ID_STATE = 'INACTIVE'
    );

    -- Delete from IDN_REST_AUTH_USER
    DELETE FROM IDN_REST_AUTH_USER
    WHERE FLOW_ID_IDENTIFIER IN (
        SELECT FLOW_ID_IDENTIFIER
        FROM IDN_REST_AUTH_FLOW
        WHERE FLOW_ID_STATE = 'EXPIRED' OR FLOW_ID_STATE = 'INACTIVE'
    );

    -- Delete from IDN_REST_AUTH_FLOW
    DELETE FROM IDN_REST_AUTH_FLOW
    WHERE FLOW_ID_STATE = 'EXPIRED' OR FLOW_ID_STATE = 'INACTIVE';
END //

DELIMITER ;
