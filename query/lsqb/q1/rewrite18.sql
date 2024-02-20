## AggReduce Phase: 

# AggReduce162
# 1. aggView
create or replace view aggView3639766986445824400 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin507515111638104116 as select CityId as v6, annot from City as City, aggView3639766986445824400 where City.isPartOf_CountryId=aggView3639766986445824400.v4;

# AggReduce163
# 1. aggView
create or replace view aggView8501057556700964758 as select v6, SUM(annot) as annot from aggJoin507515111638104116 group by v6;
# 2. aggJoin
create or replace view aggJoin4305452574175979021 as select PersonId as v8, annot from Person as Person, aggView8501057556700964758 where Person.isLocatedIn_CityId=aggView8501057556700964758.v6;

# AggReduce164
# 1. aggView
create or replace view aggView3823168783584873080 as select v8, SUM(annot) as annot from aggJoin4305452574175979021 group by v8;
# 2. aggJoin
create or replace view aggJoin4853950614657701434 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView3823168783584873080 where Forum_hasMember_Person.PersonId=aggView3823168783584873080.v8;

# AggReduce165
# 1. aggView
create or replace view aggView3213354919345159689 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin6941941170126509660 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView3213354919345159689 where Post.Forum_containerOfId=aggView3213354919345159689.v9;

# AggReduce166
# 1. aggView
create or replace view aggView6738246855675018183 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin1596435822645511228 as select TagId as v22, annot from Tag as Tag, aggView6738246855675018183 where Tag.hasType_TagClassId=aggView6738246855675018183.v23;

# AggReduce167
# 1. aggView
create or replace view aggView4288552313689547089 as select v22, SUM(annot) as annot from aggJoin1596435822645511228 group by v22;
# 2. aggJoin
create or replace view aggJoin4499027657760495990 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView4288552313689547089 where Comment_hasTag_Tag.TagId=aggView4288552313689547089.v22;

# AggReduce168
# 1. aggView
create or replace view aggView4079221340003598903 as select v20, SUM(annot) as annot from aggJoin4499027657760495990 group by v20;
# 2. aggJoin
create or replace view aggJoin3697247787677967495 as select replyOf_PostId as v18, annot from Comment as Comment, aggView4079221340003598903 where Comment.CommentId=aggView4079221340003598903.v20;

# AggReduce169
# 1. aggView
create or replace view aggView5431142381152245268 as select v18, SUM(annot) as annot from aggJoin3697247787677967495 group by v18;
# 2. aggJoin
create or replace view aggJoin5185157784052224014 as select v9, aggJoin6941941170126509660.annot * aggView5431142381152245268.annot as annot from aggJoin6941941170126509660 join aggView5431142381152245268 using(v18);

# AggReduce170
# 1. aggView
create or replace view aggView5632838134319427780 as select v9, SUM(annot) as annot from aggJoin5185157784052224014 group by v9;
# 2. aggJoin
create or replace view aggJoin2885651927462146022 as select aggJoin4853950614657701434.annot * aggView5632838134319427780.annot as annot from aggJoin4853950614657701434 join aggView5632838134319427780 using(v9);
# Final result: 
select SUM(annot) as v26 from aggJoin2885651927462146022;

# drop view aggView3639766986445824400, aggJoin507515111638104116, aggView8501057556700964758, aggJoin4305452574175979021, aggView3823168783584873080, aggJoin4853950614657701434, aggView3213354919345159689, aggJoin6941941170126509660, aggView6738246855675018183, aggJoin1596435822645511228, aggView4288552313689547089, aggJoin4499027657760495990, aggView4079221340003598903, aggJoin3697247787677967495, aggView5431142381152245268, aggJoin5185157784052224014, aggView5632838134319427780, aggJoin2885651927462146022;
