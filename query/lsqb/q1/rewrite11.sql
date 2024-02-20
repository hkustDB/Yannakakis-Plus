## AggReduce Phase: 

# AggReduce99
# 1. aggView
create or replace view aggView5952798691119812717 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin431394342987791966 as select CityId as v6, annot from City as City, aggView5952798691119812717 where City.isPartOf_CountryId=aggView5952798691119812717.v4;

# AggReduce100
# 1. aggView
create or replace view aggView139974029694442670 as select v6, SUM(annot) as annot from aggJoin431394342987791966 group by v6;
# 2. aggJoin
create or replace view aggJoin5175018043948194579 as select PersonId as v8, annot from Person as Person, aggView139974029694442670 where Person.isLocatedIn_CityId=aggView139974029694442670.v6;

# AggReduce101
# 1. aggView
create or replace view aggView6786947626396305431 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin4940944169074783418 as select TagId as v22, annot from Tag as Tag, aggView6786947626396305431 where Tag.hasType_TagClassId=aggView6786947626396305431.v23;

# AggReduce102
# 1. aggView
create or replace view aggView8482614809463344940 as select v22, SUM(annot) as annot from aggJoin4940944169074783418 group by v22;
# 2. aggJoin
create or replace view aggJoin1511144406448010615 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView8482614809463344940 where Comment_hasTag_Tag.TagId=aggView8482614809463344940.v22;

# AggReduce103
# 1. aggView
create or replace view aggView6875273064157016711 as select v20, SUM(annot) as annot from aggJoin1511144406448010615 group by v20;
# 2. aggJoin
create or replace view aggJoin783412662006712066 as select replyOf_PostId as v18, annot from Comment as Comment, aggView6875273064157016711 where Comment.CommentId=aggView6875273064157016711.v20;

# AggReduce104
# 1. aggView
create or replace view aggView1708674000451954470 as select v18, SUM(annot) as annot from aggJoin783412662006712066 group by v18;
# 2. aggJoin
create or replace view aggJoin6542785542319256840 as select Forum_containerOfId as v9, annot from Post as Post, aggView1708674000451954470 where Post.PostId=aggView1708674000451954470.v18;

# AggReduce105
# 1. aggView
create or replace view aggView2623538717602533336 as select v9, SUM(annot) as annot from aggJoin6542785542319256840 group by v9;
# 2. aggJoin
create or replace view aggJoin982170380884944825 as select ForumId as v9, annot from Forum as Forum, aggView2623538717602533336 where Forum.ForumId=aggView2623538717602533336.v9;

# AggReduce106
# 1. aggView
create or replace view aggView7311183709349856720 as select v9, SUM(annot) as annot from aggJoin982170380884944825 group by v9;
# 2. aggJoin
create or replace view aggJoin2921980559454142267 as select PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView7311183709349856720 where Forum_hasMember_Person.ForumId=aggView7311183709349856720.v9;

# AggReduce107
# 1. aggView
create or replace view aggView7794784538012650282 as select v8, SUM(annot) as annot from aggJoin2921980559454142267 group by v8;
# 2. aggJoin
create or replace view aggJoin6039677590740567475 as select aggJoin5175018043948194579.annot * aggView7794784538012650282.annot as annot from aggJoin5175018043948194579 join aggView7794784538012650282 using(v8);
# Final result: 
select SUM(annot) as v26 from aggJoin6039677590740567475;

# drop view aggView5952798691119812717, aggJoin431394342987791966, aggView139974029694442670, aggJoin5175018043948194579, aggView6786947626396305431, aggJoin4940944169074783418, aggView8482614809463344940, aggJoin1511144406448010615, aggView6875273064157016711, aggJoin783412662006712066, aggView1708674000451954470, aggJoin6542785542319256840, aggView2623538717602533336, aggJoin982170380884944825, aggView7311183709349856720, aggJoin2921980559454142267, aggView7794784538012650282, aggJoin6039677590740567475;
