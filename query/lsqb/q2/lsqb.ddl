CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (CompanyId)
) WITH (
        'cardinality' = '1575'
);
CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (UniversityId)
) WITH (
        'cardinality' = '6380'
);
CREATE TABLE Continent (
    ContinentId bigint,
    PRIMARY KEY (ContinentId)
) WITH (
        'cardinality' = '6'
);
CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint,
    PRIMARY KEY (CountryId)
) WITH (
        'cardinality' = '111'
);
CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint,
    PRIMARY KEY (CityId)
) WITH (
        'cardinality' = '1343'
);
CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint,
    PRIMARY KEY (TagId)
) WITH (
        'cardinality' = '16080'
);
CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint,
    PRIMARY KEY (TagClassId)
) WITH (
        'cardinality' = '71'
);
CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint,
    PRIMARY KEY (ForumId)
) WITH (
        'cardinality' = '1831640'
);
CREATE TABLE `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint,
    PRIMARY KEY (CommentId)
) WITH (
        'cardinality' = '7711046'
);
CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (PostId)
) WITH (
        'cardinality' = '24025658'
);
CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (PersonId)
) WITH (
        'cardinality' = '184000'
);

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint,
	PRIMARY KEY (CommentId, TagId)
) WITH (
        'cardinality' = '96662059'
);

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint,
	PRIMARY KEY (PostId, TagId)
) WITH (
        'cardinality' = '25336957'
);

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint,
	PRIMARY KEY (ForumId, PersonId)
) WITH (
        'cardinality' = '105337003'
);

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint,
	PRIMARY KEY (ForumId, TagId)
) WITH (
        'cardinality' = '2362408'
);

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint,
	PRIMARY KEY (PersonId, TagId)
) WITH (
        'cardinality' = '4289970'
);

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint,
	PRIMARY KEY (PersonId, CommentId)
) WITH (
        'cardinality' = '68979133'
);

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint,
	PRIMARY KEY (PersonId, PostId)
) WITH (
        'cardinality' = '30729218'
);

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint,
	PRIMARY KEY (PersonId)
) WITH (
        'cardinality' = '147243'
);

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint,
	PRIMARY KEY (PersonId, CompanyId)
) WITH (
        'cardinality' = '400460'
);

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint,
	PRIMARY KEY (Person1Id, Person2Id)
) WITH (
        'cardinality' = '7273036'
);

CREATE TABLE Message (
	MessageId bigint,
	PRIMARY KEY (MessageId)
) WITH (
        'cardinality' = '101136134'
);

CREATE TABLE Comment_replyOf_Message (
	CommentId bigint,
	ParentMessageId bigint,
	PRIMARY KEY (CommentId)
) WITH (
        'cardinality' = '77110476'
);

CREATE TABLE Message_hasCreator_Person (
	MessageId bigint,
	hasCreator_PersonId bigint,
	PRIMARY KEY (MessageId)
) WITH (
        'cardinality' = '101136134'
);

CREATE TABLE Message_hasTag_Tag (
	MessageId bigint,
	TagId bigint,
	PRIMARY KEY (MessageId, TagId)
) WITH (
        'cardinality' = '121999016'
);

CREATE TABLE Message_isLocatedIn_Country (
	MessageId bigint,
	isLocatedIn_CountryId bigint,
	PRIMARY KEY (MessageId)
) WITH (
        'cardinality' = '101136134'
);

CREATE TABLE Person_likes_Message (
	PersonId bigint,
	MessageId bigint,
	PRIMARY KEY (PersonId, MessageId)
) WITH (
        'cardinality' = '99708351'
);

