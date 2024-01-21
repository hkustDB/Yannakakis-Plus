CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint
);
CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint
);
CREATE TABLE Continent (
    ContinentId bigint
);
CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint
);
CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint
);
CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint
);
CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint
);
CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint
);
CREATE TABLE `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint
);
CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint
);
CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint
);

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint
);

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint
);

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint
);

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint
);

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint
);

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint
);

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint
);

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint
);

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint
);

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint
);

CREATE TABLE Message (
	MessageId bigint
);

CREATE TABLE Comment_replyOf_Message (
	CommentId bigint,
	ParentMessageId bigint
);

CREATE TABLE Message_hasCreator_Person (
	MessageId bigint,
	hasCreator_PersonId bigint
);

CREATE TABLE Message_hasTag_Tag (
	MessageId bigint,
	TagId bigint
);

CREATE TABLE Message_isLocatedIn_Country (
	MessageId bigint,
	isLocatedIn_CountryId bigint
);

CREATE TABLE Person_likes_Message (
	PersonId bigint,
	MessageId bigint
);

