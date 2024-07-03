CREATE TABLE Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (CompanyId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Company.csv';
CREATE TABLE University (
    UniversityId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (UniversityId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/University.csv';
CREATE TABLE Continent (
    ContinentId bigint,
    PRIMARY KEY (ContinentId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Continent.csv';
CREATE TABLE Country (
    CountryId bigint,
    isPartOf_ContinentId bigint,
    PRIMARY KEY (CountryId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Country.csv';
CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint,
    PRIMARY KEY (CityId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/City.csv';
CREATE TABLE Tag (
    TagId bigint,
    hasType_TagClassId bigint,
    PRIMARY KEY (TagId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Tag.csv';
CREATE TABLE TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint,
    PRIMARY KEY (TagClassId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Forum.csv';
CREATE TABLE Forum (
    ForumId bigint,
    hasModerator_PersonId bigint,
    PRIMARY KEY (ForumId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Forum.csv';
CREATE TABLE `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint,
    PRIMARY KEY (CommentId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Comment.csv';
CREATE TABLE Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint,
    PRIMARY KEY (PostId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Post.csv';
CREATE TABLE Person (
    PersonId bigint,
    isLocatedIn_CityId bigint,
    PRIMARY KEY (PersonId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person.csv';

CREATE TABLE Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint,
	PRIMARY KEY (CommentId, TagId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Comment_hasTag_Tag.csv';

CREATE TABLE Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint,
	PRIMARY KEY (PostId, TagId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Post_hasTag_Tag.csv';

CREATE TABLE Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint,
	PRIMARY KEY (ForumId, PersonId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Forum_hasMember_Person.csv';

CREATE TABLE Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint,
	PRIMARY KEY (ForumId, TagId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Forum_hasTag_Tag.csv';

CREATE TABLE Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint,
	PRIMARY KEY (PersonId, TagId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_hasInterest_Tag.csv';

CREATE TABLE Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint,
	PRIMARY KEY (PersonId, CommentId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_likes_Comment.csv';

CREATE TABLE Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint,
	PRIMARY KEY (PersonId, PostId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_likes_Post.csv';

CREATE TABLE Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint,
	PRIMARY KEY (PersonId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_studyAt_University.csv';

CREATE TABLE Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint,
	PRIMARY KEY (PersonId, CompanyId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_workAt_Company.csv';

CREATE TABLE Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint,
	PRIMARY KEY (Person1Id, Person2Id)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_knows_Person.csv';

CREATE TABLE Message (
	MessageId bigint,
	PRIMARY KEY (MessageId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Message.csv';

CREATE TABLE Comment_replyOf_Message (
	CommentId bigint,
	ParentMessageId bigint,
	PRIMARY KEY (CommentId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Comment_replyOf_Message.csv';

CREATE TABLE Message_hasCreator_Person (
	MessageId bigint,
	hasCreator_PersonId bigint,
	PRIMARY KEY (MessageId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Message_hasCreator_Person.csv';

CREATE TABLE Message_hasTag_Tag (
	MessageId bigint,
	TagId bigint,
	PRIMARY KEY (MessageId, TagId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Message_hasTag_Tag.csv';

CREATE TABLE Message_isLocatedIn_Country (
	MessageId bigint,
	isLocatedIn_CountryId bigint,
	PRIMARY KEY (MessageId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Message_isLocatedIn_Country.csv';

CREATE TABLE Person_likes_Message (
	PersonId bigint,
	MessageId bigint,
	PRIMARY KEY (PersonId, MessageId)
) USING CSV LOCATION '/home/data/lsqb/data/social-network-sf10-merged-fk/Person_likes_Message.csv';

