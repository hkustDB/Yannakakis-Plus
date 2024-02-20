## AggReduce Phase: 

# AggReduce90
# 1. aggView
create or replace view aggView643313253303476359 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin6992587781565185546 as select CityId as v6, annot from City as City, aggView643313253303476359 where City.isPartOf_CountryId=aggView643313253303476359.v4;

# AggReduce91
# 1. aggView
create or replace view aggView488354826670726585 as select v6, SUM(annot) as annot from aggJoin6992587781565185546 group by v6;
# 2. aggJoin
create or replace view aggJoin3608970337660750975 as select PersonId as v8, annot from Person as Person, aggView488354826670726585 where Person.isLocatedIn_CityId=aggView488354826670726585.v6;

# AggReduce92
# 1. aggView
create or replace view aggView6370939218238809867 as select v8, SUM(annot) as annot from aggJoin3608970337660750975 group by v8;
# 2. aggJoin
create or replace view aggJoin5700232170933092129 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6370939218238809867 where Forum_hasMember_Person.PersonId=aggView6370939218238809867.v8;

# AggReduce93
# 1. aggView
create or replace view aggView3855320387674530675 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin2988862820059733505 as select TagId as v22, annot from Tag as Tag, aggView3855320387674530675 where Tag.hasType_TagClassId=aggView3855320387674530675.v23;

# AggReduce94
# 1. aggView
create or replace view aggView9074353562387912073 as select v22, SUM(annot) as annot from aggJoin2988862820059733505 group by v22;
# 2. aggJoin
create or replace view aggJoin6469672269412362842 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView9074353562387912073 where Comment_hasTag_Tag.TagId=aggView9074353562387912073.v22;

# AggReduce95
# 1. aggView
create or replace view aggView3023205878050631978 as select v20, SUM(annot) as annot from aggJoin6469672269412362842 group by v20;
# 2. aggJoin
create or replace view aggJoin2810118396123674296 as select replyOf_PostId as v18, annot from Comment as Comment, aggView3023205878050631978 where Comment.CommentId=aggView3023205878050631978.v20;

# AggReduce96
# 1. aggView
create or replace view aggView7403922632281835260 as select v18, SUM(annot) as annot from aggJoin2810118396123674296 group by v18;
# 2. aggJoin
create or replace view aggJoin5682774444102777986 as select Forum_containerOfId as v9, annot from Post as Post, aggView7403922632281835260 where Post.PostId=aggView7403922632281835260.v18;

# AggReduce97
# 1. aggView
create or replace view aggView2966142509301605476 as select v9, SUM(annot) as annot from aggJoin5682774444102777986 group by v9;
# 2. aggJoin
create or replace view aggJoin3140460322608788400 as select ForumId as v9, annot from Forum as Forum, aggView2966142509301605476 where Forum.ForumId=aggView2966142509301605476.v9;

# AggReduce98
# 1. aggView
create or replace view aggView602317199985301625 as select v9, SUM(annot) as annot from aggJoin3140460322608788400 group by v9;
# 2. aggJoin
create or replace view aggJoin2076458958869109513 as select aggJoin5700232170933092129.annot * aggView602317199985301625.annot as annot from aggJoin5700232170933092129 join aggView602317199985301625 using(v9);
# Final result: 
select SUM(annot) as v26 from aggJoin2076458958869109513;

# drop view aggView643313253303476359, aggJoin6992587781565185546, aggView488354826670726585, aggJoin3608970337660750975, aggView6370939218238809867, aggJoin5700232170933092129, aggView3855320387674530675, aggJoin2988862820059733505, aggView9074353562387912073, aggJoin6469672269412362842, aggView3023205878050631978, aggJoin2810118396123674296, aggView7403922632281835260, aggJoin5682774444102777986, aggView2966142509301605476, aggJoin3140460322608788400, aggView602317199985301625, aggJoin2076458958869109513;
