CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (CompanyId)
);
COPY NATION FROM '/path/to/Company.tbl' (AUTO_DETECT true);

CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (UniversityId)
);
COPY NATION FROM '/path/to/University.tbl' (AUTO_DETECT true);

CREATE TABLE Continent (
    ContinentId bigint,
    PRIMARY KEY (ContinentId)
);
COPY NATION FROM '/path/to/Continent.tbl' (AUTO_DETECT true);

CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint,
    PRIMARY KEY (CountryId)
);
COPY NATION FROM '/path/to/Country.tbl' (AUTO_DETECT true);

CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint,
    PRIMARY KEY (CityId)
);
COPY NATION FROM '/path/to/City.tbl' (AUTO_DETECT true);

CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint,
    PRIMARY KEY (TagId)
);
COPY NATION FROM '/path/to/Tag.tbl' (AUTO_DETECT true);

CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint,
    PRIMARY KEY (TagClassId)
);
COPY NATION FROM '/path/to/TagClass.tbl' (AUTO_DETECT true);

CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint,
    PRIMARY KEY (ForumId)
);
COPY NATION FROM '/path/to/Forum.tbl' (AUTO_DETECT true);

CREATE TABLE `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint,
    PRIMARY KEY (CommentId)
);
COPY NATION FROM '/path/to/Comment.tbl' (AUTO_DETECT true);

CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (PostId)
);
COPY NATION FROM '/path/to/Post.tbl' (AUTO_DETECT true);

CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (PersonId)
);
COPY NATION FROM '/path/to/Person.tbl' (AUTO_DETECT true);

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint,
	PRIMARY KEY (CommentId, TagId)
);
COPY NATION FROM '/path/to/Comment_hasTag_Tag.tbl' (AUTO_DETECT true);

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint,
	PRIMARY KEY (PostId, TagId)
);
COPY NATION FROM '/path/to/Post_hasTag_Tag.tbl' (AUTO_DETECT true);

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint,
	PRIMARY KEY (ForumId, PersonId)
);
COPY NATION FROM '/path/to/Forum_hasMember_Person.tbl' (AUTO_DETECT true);

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint,
	PRIMARY KEY (ForumId, TagId)
);
COPY NATION FROM '/path/to/Forum_hasTag_Tag.tbl' (AUTO_DETECT true);

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint,
	PRIMARY KEY (PersonId, TagId)
);
COPY NATION FROM '/path/to/Person_hasInterest_Tag.tbl' (AUTO_DETECT true);

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint,
	PRIMARY KEY (PersonId, CommentId)
);
COPY NATION FROM '/path/to/Person_likes_Comment.tbl' (AUTO_DETECT true);

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint,
	PRIMARY KEY (PersonId, PostId)
);
COPY NATION FROM '/path/to/Person_likes_Post.tbl' (AUTO_DETECT true);

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint,
	PRIMARY KEY (PersonId)
);
COPY NATION FROM '/path/to/Person_studyAt_University.tbl' (AUTO_DETECT true);

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint,
	PRIMARY KEY (PersonId, CompanyId)
);
COPY NATION FROM '/path/to/Person_workAt_Company.tbl' (AUTO_DETECT true);

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint,
	PRIMARY KEY (Person1Id, Person2Id)
);
COPY NATION FROM '/path/to/Person_knows_Person.tbl' (AUTO_DETECT true);
