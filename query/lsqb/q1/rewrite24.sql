## AggReduce Phase: 

# AggReduce216
# 1. aggView
create or replace view aggView3801638873992752398 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin1276307539952754452 as select CityId as v6, annot from City as City, aggView3801638873992752398 where City.isPartOf_CountryId=aggView3801638873992752398.v4;

# AggReduce217
# 1. aggView
create or replace view aggView6246981746062971913 as select v6, SUM(annot) as annot from aggJoin1276307539952754452 group by v6;
# 2. aggJoin
create or replace view aggJoin8544639611139623456 as select PersonId as v8, annot from Person as Person, aggView6246981746062971913 where Person.isLocatedIn_CityId=aggView6246981746062971913.v6;

# AggReduce218
# 1. aggView
create or replace view aggView6917541669785516113 as select v8, SUM(annot) as annot from aggJoin8544639611139623456 group by v8;
# 2. aggJoin
create or replace view aggJoin3464379577599849908 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6917541669785516113 where Forum_hasMember_Person.PersonId=aggView6917541669785516113.v8;

# AggReduce219
# 1. aggView
create or replace view aggView440262310462654836 as select v9, SUM(annot) as annot from aggJoin3464379577599849908 group by v9;
# 2. aggJoin
create or replace view aggJoin1273748509389799539 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView440262310462654836 where Post.Forum_containerOfId=aggView440262310462654836.v9;

# AggReduce220
# 1. aggView
create or replace view aggView7104821321602056190 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin2465905082449610934 as select v18, aggJoin1273748509389799539.annot * aggView7104821321602056190.annot as annot from aggJoin1273748509389799539 join aggView7104821321602056190 using(v9);

# AggReduce221
# 1. aggView
create or replace view aggView8399777328477054064 as select v18, SUM(annot) as annot from aggJoin2465905082449610934 group by v18;
# 2. aggJoin
create or replace view aggJoin6630798584993149916 as select CommentId as v20, annot from Comment as Comment, aggView8399777328477054064 where Comment.replyOf_PostId=aggView8399777328477054064.v18;

# AggReduce222
# 1. aggView
create or replace view aggView4624815083766478369 as select v20, SUM(annot) as annot from aggJoin6630798584993149916 group by v20;
# 2. aggJoin
create or replace view aggJoin6815666886092040068 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView4624815083766478369 where Comment_hasTag_Tag.CommentId=aggView4624815083766478369.v20;

# AggReduce223
# 1. aggView
create or replace view aggView6809741144661862138 as select v22, SUM(annot) as annot from aggJoin6815666886092040068 group by v22;
# 2. aggJoin
create or replace view aggJoin1158923712539618870 as select hasType_TagClassId as v23, annot from Tag as Tag, aggView6809741144661862138 where Tag.TagId=aggView6809741144661862138.v22;

# AggReduce224
# 1. aggView
create or replace view aggView4039751600386834088 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin6261959978993023602 as select aggJoin1158923712539618870.annot * aggView4039751600386834088.annot as annot from aggJoin1158923712539618870 join aggView4039751600386834088 using(v23);
# Final result: 
select SUM(annot) as v26 from aggJoin6261959978993023602;

# drop view aggView3801638873992752398, aggJoin1276307539952754452, aggView6246981746062971913, aggJoin8544639611139623456, aggView6917541669785516113, aggJoin3464379577599849908, aggView440262310462654836, aggJoin1273748509389799539, aggView7104821321602056190, aggJoin2465905082449610934, aggView8399777328477054064, aggJoin6630798584993149916, aggView4624815083766478369, aggJoin6815666886092040068, aggView6809741144661862138, aggJoin1158923712539618870, aggView4039751600386834088, aggJoin6261959978993023602;
