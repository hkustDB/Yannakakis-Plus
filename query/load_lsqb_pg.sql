CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (CompanyId)
);
COPY Company FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Company.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (UniversityId)
);
COPY University FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/University.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Continent (
    ContinentId bigint,
    PRIMARY KEY (ContinentId)
);
COPY Continent FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Continent.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint,
    PRIMARY KEY (CountryId)
);
COPY Country FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Country.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint,
    PRIMARY KEY (CityId)
);
COPY City FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/City.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint,
    PRIMARY KEY (TagId)
);
COPY Tag FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Tag.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint,
    PRIMARY KEY (TagClassId)
);
COPY TagClass FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/TagClass.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint,
    PRIMARY KEY (ForumId)
);
COPY Forum FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Forum.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Comment (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint,
    PRIMARY KEY (CommentId)
);
COPY Comment FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Comment.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (PostId)
);
COPY Post FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Post.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (PersonId)
);
COPY Person FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint,
	PRIMARY KEY (CommentId, TagId)
);
COPY Comment_hasTag_Tag FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Comment_hasTag_Tag.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint,
	PRIMARY KEY (PostId, TagId)
);
COPY Post_hasTag_Tag FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Post_hasTag_Tag.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint,
	PRIMARY KEY (ForumId, PersonId)
);
COPY Forum_hasMember_Person FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Forum_hasMember_Person.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint,
	PRIMARY KEY (ForumId, TagId)
);
COPY Forum_hasTag_Tag FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Forum_hasTag_Tag.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint,
	PRIMARY KEY (PersonId, TagId)
);
COPY Person_hasInterest_Tag FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_hasInterest_Tag.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint,
	PRIMARY KEY (PersonId, CommentId)
);
COPY Person_likes_Comment FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_likes_Comment.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint,
	PRIMARY KEY (PersonId, PostId)
);
COPY Person_likes_Post FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_likes_Post.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint,
	PRIMARY KEY (PersonId)
);
COPY Person_studyAt_University FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_studyAt_University.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint,
	PRIMARY KEY (PersonId, CompanyId)
);
COPY Person_workAt_Company FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_workAt_Company.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint,
	PRIMARY KEY (Person1Id, Person2Id)
);
COPY Person_knows_Person FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_knows_Person.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');

CREATE TABLE Person_knows_Person2      (
	Person1Id bigint, 
	Person2Id    bigint,
	PRIMARY KEY (Person1Id, Person2Id)
);
COPY Person_knows_Person2 FROM '/home/bchenba/lsqb/data/social-network-sf10-merged-fk/Person_knows_Person.csv' WITH (FORMAT CSV, HEADER true, DELIMITER '|');
insert into Person_knows_Person select Person2Id, Person1Id from Person_knows_Person2;

CREATE VIEW Message AS
  SELECT CommentId AS MessageId FROM Comment
  UNION ALL
  SELECT PostId AS MessageId FROM Post;

CREATE VIEW Comment_replyOf_Message AS
  SELECT CommentId, replyOf_PostId AS ParentMessageId FROM Comment
  WHERE replyOf_PostId IS NOT NULL
  UNION ALL
  SELECT CommentId, replyOf_CommentId AS ParentMessageId FROM Comment
  WHERE replyOf_CommentId IS NOT NULL;

CREATE VIEW Message_hasCreator_Person AS
  SELECT CommentId AS MessageId, hasCreator_PersonId FROM Comment
  UNION ALL
  SELECT PostId AS MessageId, hasCreator_PersonId FROM Post;

CREATE VIEW Message_hasTag_Tag AS
  SELECT CommentId AS MessageId, TagId FROM Comment_hasTag_Tag
  UNION ALL
  SELECT PostId AS MessageId, TagId FROM Post_hasTag_Tag;
 
CREATE VIEW Message_isLocatedIn_Country AS
  SELECT CommentId AS MessageId, isLocatedIn_CountryId FROM Comment
  UNION ALL
  SELECT PostId AS MessageId, isLocatedIn_CountryId FROM Post;

CREATE VIEW Person_likes_Message AS
  SELECT PersonId, CommentId AS MessageId FROM Person_likes_Comment
  UNION ALL
  SELECT PersonId, PostId AS MessageId FROM Person_likes_Post;