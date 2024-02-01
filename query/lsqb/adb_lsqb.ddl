CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE Continent (
    ContinentId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint
) DISTRIBUTED BY BROADCAST;

CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint
) DISTRIBUTED BY HASH (ForumId);

CREATE TABLE `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint
) DISTRIBUTED BY HASH (CommentId);

CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint
) DISTRIBUTED BY HASH (PostId);

CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint
) DISTRIBUTED BY HASH (PersonId);

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (CommentId);

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (PostId);

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint
) DISTRIBUTED BY HASH (ForumId);

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (ForumId);

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (PersonId);

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint
) DISTRIBUTED BY HASH (PersonId);

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint
) DISTRIBUTED BY HASH (PersonId);

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint
) DISTRIBUTED BY HASH (PersonId);

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint
) DISTRIBUTED BY HASH (PersonId);

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint
) DISTRIBUTED BY HASH (Person1Id);
