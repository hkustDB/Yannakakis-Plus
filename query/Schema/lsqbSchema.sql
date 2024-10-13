CREATE TABLE aCompanyB (
    CompanyId bigint,
    isLocatedIn_CountryId bigint
);
CREATE TABLE eUniversityF (
    UniversityId bigint,
    isLocatedIn_CityId bigint
);
CREATE TABLE Continent (
    ContinentId bigint
);
CREATE TABLE cCountryD (
    CountryId bigint,
    isPartOf_ContinentId bigint
);
CREATE TABLE City (
    CityId bigint,
    isPartOf_CountryId bigint
);
CREATE TABLE aTagB (
    TagId bigint,
    hasType_TagClassId bigint
);
CREATE TABLE cTagClassD (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint
);
CREATE TABLE QForumQ (
    ForumId bigint,
    hasModerator_PersonId bigint
);
CREATE TABLE dCommentd (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint
);
CREATE TABLE hPosth (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint
);
CREATE TABLE lPersonl (
    PersonId bigint,
    isLocatedIn_CityId bigint
);

CREATE TABLE eComment_hasTag_TagF       (
	CommentId bigint, 
	TagId        bigint
);

CREATE TABLE gPost_hasTag_TagH          (
	PostId    bigint, 
	TagId        bigint
);

CREATE TABLE mForum_hasMember_PersonN   (
	ForumId   bigint, 
	PersonId     bigint
);

CREATE TABLE iForum_hasTag_TagJ         (
	ForumId   bigint, 
	TagId        bigint
);

CREATE TABLE kPerson_hasInterest_TagM   (
	PersonId  bigint, 
	TagId        bigint
);

CREATE TABLE APerson_likes_CommentC     (
	PersonId  bigint, 
	CommentId    bigint
);

CREATE TABLE oPerson_likes_PostP        (
	PersonId  bigint, 
	PostId       bigint
);
CREATE TABLE MPerson_studyAt_UniversityN(
	PersonId  bigint, 
	UniversityId bigint
);

CREATE TABLE cPerson_workAt_CompanyD    (
	PersonId  bigint, 
	CompanyId    bigint
);

CREATE TABLE qPerson_knows_PersonR      (
	Person1Id bigint, 
	Person2Id    bigint
);