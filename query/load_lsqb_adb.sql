CREATE TABLE IF NOT EXISTS Company (
    CompanyId bigint,
    isLocatedIn_CountryId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS University (
    UniversityId bigint,
    isLocatedIn_CityId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS Continent (
    ContinentId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS Country (
    CountryId bigint,
    isPartOf_ContinentId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS City (
    CityId bigint,
    isPartOf_CountryId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS Tag (
    TagId bigint,
    hasType_TagClassId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS TagClass (
    TagClassId bigint,
    isSubclassOf_TagClassId bigint
) DISTRIBUTED BY BROADCAST;
CREATE TABLE IF NOT EXISTS Forum (
    ForumId bigint,
    hasModerator_PersonId bigint
) DISTRIBUTED BY HASH (ForumId);
CREATE TABLE IF NOT EXISTS `Comment` (
    CommentId bigint,
    hasCreator_PersonId bigint,
    isLocatedIn_CountryId bigint,
    replyOf_PostId bigint,
    replyOf_CommentId bigint
) DISTRIBUTED BY HASH (CommentId);
CREATE TABLE IF NOT EXISTS Post (
    PostId bigint,
    hasCreator_PersonId bigint,
    Forum_containerOfId bigint,
    isLocatedIn_CountryId bigint
) DISTRIBUTED BY HASH (PostId);
CREATE TABLE IF NOT EXISTS Person (
    PersonId bigint,
    isLocatedIn_CityId bigint
) DISTRIBUTED BY HASH (PersonId);
CREATE TABLE IF NOT EXISTS Comment_hasTag_Tag       (
	CommentId bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (CommentId);
CREATE TABLE IF NOT EXISTS Post_hasTag_Tag          (
	PostId    bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (PostId);
CREATE TABLE IF NOT EXISTS Forum_hasMember_Person   (
	ForumId   bigint, 
	PersonId     bigint
) DISTRIBUTED BY HASH (ForumId);
CREATE TABLE IF NOT EXISTS Forum_hasTag_Tag         (
	ForumId   bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (ForumId);
CREATE TABLE IF NOT EXISTS Person_hasInterest_Tag   (
	PersonId  bigint, 
	TagId        bigint
) DISTRIBUTED BY HASH (PersonId);
CREATE TABLE IF NOT EXISTS Person_likes_Comment     (
	PersonId  bigint, 
	CommentId    bigint
) DISTRIBUTED BY HASH (PersonId);
CREATE TABLE IF NOT EXISTS Person_likes_Post        (
	PersonId  bigint, 
	PostId       bigint
) DISTRIBUTED BY HASH (PersonId);
CREATE TABLE IF NOT EXISTS Person_studyAt_University(
	PersonId  bigint, 
	UniversityId bigint
) DISTRIBUTED BY HASH (PersonId);
CREATE TABLE IF NOT EXISTS Person_workAt_Company    (
	PersonId  bigint, 
	CompanyId    bigint
) DISTRIBUTED BY HASH (PersonId);
CREATE TABLE IF NOT EXISTS Person_knows_Person      (
	Person1Id bigint, 
	Person2Id    bigint
) DISTRIBUTED BY HASH (Person1Id);

submit job insert overwrite into Company select * from oss_Company_10;
submit job insert overwrite into University select * from oss_University_10;
submit job insert overwrite into Continent select * from oss_Continent_10;
submit job insert overwrite into Country select * from oss_Country_10;
submit job insert overwrite into City select * from oss_City_10;
submit job insert overwrite into Tag select * from oss_Tag_10;
submit job insert overwrite into TagClass select * from oss_TagClass_10;
submit job insert overwrite into Forum select * from oss_Forum_10;
submit job insert overwrite into `Comment` select * from oss_Comment_10;
submit job insert overwrite into Post select * from oss_Post_10;
submit job insert overwrite into Person select * from oss_Person_10;
submit job insert overwrite into Comment_hasTag_Tag select * from oss_Comment_hasTag_Tag_10;
submit job insert overwrite into Post_hasTag_Tag select * from oss_Post_hasTag_Tag_10;
submit job insert overwrite into Forum_hasMember_Person select * from oss_Forum_hasMember_Person_10;
submit job insert overwrite into Person_hasInterest_Tag select * from oss_Person_hasInterest_Tag_10;
submit job insert overwrite into Person_likes_Comment select * from oss_Person_likes_Comment_10;
submit job insert overwrite into Person_likes_Post select * from oss_Person_likes_Post_10;
submit job insert overwrite into Person_studyAt_University select * from oss_Person_studyAt_University_10;
submit job insert overwrite into Person_workAt_Company select * from oss_Person_workAt_Company_10;
submit job insert overwrite into Person_knows_Person select * from oss_Person_knows_Person_10;
submit job insert into Person_knows_Person select Person2Id, Person1Id from oss_Person_knows_Person_10;

analyze table Company UPDATE HISTOGRAM;
analyze table University UPDATE HISTOGRAM;
analyze table Continent UPDATE HISTOGRAM;
analyze table Country UPDATE HISTOGRAM;
analyze table City UPDATE HISTOGRAM;
analyze table Tag UPDATE HISTOGRAM;
analyze table TagClass UPDATE HISTOGRAM;
analyze table Forum UPDATE HISTOGRAM;
analyze table `Comment` UPDATE HISTOGRAM;
analyze table Post UPDATE HISTOGRAM;
analyze table Person UPDATE HISTOGRAM;
analyze table Comment_hasTag_Tag UPDATE HISTOGRAM;
analyze table Post_hasTag_Tag UPDATE HISTOGRAM;
analyze table Forum_hasMember_Person UPDATE HISTOGRAM;
analyze table Forum_hasTag_Tag UPDATE HISTOGRAM;
analyze table Person_hasInterest_Tag UPDATE HISTOGRAM;
analyze table Person_likes_Comment UPDATE HISTOGRAM;
analyze table Person_likes_Post UPDATE HISTOGRAM;
analyze table Person_studyAt_University UPDATE HISTOGRAM;
analyze table Person_workAt_Company UPDATE HISTOGRAM;
analyze table Person_knows_Person UPDATE HISTOGRAM;
CREATE or replace VIEW Message AS
  SELECT CommentId AS MessageId FROM Comment
  UNION ALL
  SELECT PostId AS MessageId FROM Post;
CREATE or replace VIEW Comment_replyOf_Message AS
  SELECT CommentId, replyOf_PostId AS ParentMessageId FROM Comment
  WHERE replyOf_PostId IS NOT NULL
  UNION ALL
  SELECT CommentId, replyOf_CommentId AS ParentMessageId FROM Comment
  WHERE replyOf_CommentId IS NOT NULL;
CREATE or replace VIEW Message_hasCreator_Person AS
  SELECT CommentId AS MessageId, hasCreator_PersonId FROM Comment
  UNION ALL
  SELECT PostId AS MessageId, hasCreator_PersonId FROM Post;
CREATE or replace VIEW Message_hasTag_Tag AS
  SELECT CommentId AS MessageId, TagId FROM Comment_hasTag_Tag
  UNION ALL
  SELECT PostId AS MessageId, TagId FROM Post_hasTag_Tag;
CREATE or replace VIEW Message_isLocatedIn_Country AS
  SELECT CommentId AS MessageId, isLocatedIn_CountryId FROM Comment
  UNION ALL
  SELECT PostId AS MessageId, isLocatedIn_CountryId FROM Post;
CREATE or replace VIEW Person_likes_Message AS
  SELECT PersonId, CommentId AS MessageId FROM Person_likes_Comment
  UNION ALL
  SELECT PersonId, PostId AS MessageId FROM Person_likes_Post;