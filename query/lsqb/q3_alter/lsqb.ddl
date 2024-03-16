CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (CompanyId)
);
CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (UniversityId)
);
CREATE TABLE Continent (
    ContinentId bigint,
    PRIMARY KEY (ContinentId)
);
CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint,
    PRIMARY KEY (CountryId)
);
CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint,
    PRIMARY KEY (CityId)
);
CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint,
    PRIMARY KEY (TagId)
);
CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint,
    PRIMARY KEY (TagClassId)
);
CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint,
    PRIMARY KEY (ForumId)
);
CREATE TABLE `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint,
    PRIMARY KEY (CommentId)
);
CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (PostId)
);
CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (PersonId)
);

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint,
	PRIMARY KEY (CommentId, TagId)
);

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint,
	PRIMARY KEY (PostId, TagId)
);

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint,
	PRIMARY KEY (ForumId, PersonId)
);

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint,
	PRIMARY KEY (ForumId, TagId)
);

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint,
	PRIMARY KEY (PersonId, TagId)
);

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint,
	PRIMARY KEY (PersonId, CommentId)
);

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint,
	PRIMARY KEY (PersonId, PostId)
);

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint,
	PRIMARY KEY (PersonId)
);

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint,
	PRIMARY KEY (PersonId, CompanyId)
);

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint,
	PRIMARY KEY (Person1Id, Person2Id)
);

CREATE TABLE Message (
	MessageId bigint,
	PRIMARY KEY (MessageId)
);

CREATE TABLE Comment_replyOf_Message (
	CommentId bigint,
	ParentMessageId bigint,
	PRIMARY KEY (CommentId)
);

CREATE TABLE Message_hasCreator_Person (
	MessageId bigint,
	hasCreator_PersonId bigint,
	PRIMARY KEY (MessageId)
);

CREATE TABLE Message_hasTag_Tag (
	MessageId bigint,
	TagId bigint,
	PRIMARY KEY (MessageId, TagId)
);

CREATE TABLE Message_isLocatedIn_Country (
	MessageId bigint,
	isLocatedIn_CountryId bigint,
	PRIMARY KEY (MessageId)
);

CREATE TABLE Person_likes_Message (
	PersonId bigint,
	MessageId bigint,
	PRIMARY KEY (PersonId, MessageId)
);

