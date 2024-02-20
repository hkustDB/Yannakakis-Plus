## AggReduce Phase: 

# AggReduce234
# 1. aggView
create or replace view aggView433104781967169572 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin5230298953078732059 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView433104781967169572 where Forum_hasMember_Person.ForumId=aggView433104781967169572.v9;

# AggReduce235
# 1. aggView
create or replace view aggView5107070244101175452 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin1047261748894162172 as select CityId as v6, annot from City as City, aggView5107070244101175452 where City.isPartOf_CountryId=aggView5107070244101175452.v4;

# AggReduce236
# 1. aggView
create or replace view aggView3931154298323322284 as select v6, SUM(annot) as annot from aggJoin1047261748894162172 group by v6;
# 2. aggJoin
create or replace view aggJoin6045540677388992152 as select PersonId as v8, annot from Person as Person, aggView3931154298323322284 where Person.isLocatedIn_CityId=aggView3931154298323322284.v6;

# AggReduce237
# 1. aggView
create or replace view aggView9021671093864814396 as select v8, SUM(annot) as annot from aggJoin6045540677388992152 group by v8;
# 2. aggJoin
create or replace view aggJoin1519446593614370003 as select v9, aggJoin5230298953078732059.annot * aggView9021671093864814396.annot as annot from aggJoin5230298953078732059 join aggView9021671093864814396 using(v8);

# AggReduce238
# 1. aggView
create or replace view aggView2502170862885217167 as select v9, SUM(annot) as annot from aggJoin1519446593614370003 group by v9;
# 2. aggJoin
create or replace view aggJoin4417953249263473839 as select PostId as v18, annot from Post as Post, aggView2502170862885217167 where Post.Forum_containerOfId=aggView2502170862885217167.v9;

# AggReduce239
# 1. aggView
create or replace view aggView3759540700435724897 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin7624068694722687955 as select TagId as v22, annot from Tag as Tag, aggView3759540700435724897 where Tag.hasType_TagClassId=aggView3759540700435724897.v23;

# AggReduce240
# 1. aggView
create or replace view aggView2479313635270793403 as select v22, SUM(annot) as annot from aggJoin7624068694722687955 group by v22;
# 2. aggJoin
create or replace view aggJoin5623344103256099372 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView2479313635270793403 where Comment_hasTag_Tag.TagId=aggView2479313635270793403.v22;

# AggReduce241
# 1. aggView
create or replace view aggView9212922144455328629 as select v20, SUM(annot) as annot from aggJoin5623344103256099372 group by v20;
# 2. aggJoin
create or replace view aggJoin6150284473234106904 as select replyOf_PostId as v18, annot from Comment as Comment, aggView9212922144455328629 where Comment.CommentId=aggView9212922144455328629.v20;

# AggReduce242
# 1. aggView
create or replace view aggView8785141847638363295 as select v18, SUM(annot) as annot from aggJoin6150284473234106904 group by v18;
# 2. aggJoin
create or replace view aggJoin5544354300917487679 as select aggJoin4417953249263473839.annot * aggView8785141847638363295.annot as annot from aggJoin4417953249263473839 join aggView8785141847638363295 using(v18);
# Final result: 
select SUM(annot) as v26 from aggJoin5544354300917487679;

# drop view aggView433104781967169572, aggJoin5230298953078732059, aggView5107070244101175452, aggJoin1047261748894162172, aggView3931154298323322284, aggJoin6045540677388992152, aggView9021671093864814396, aggJoin1519446593614370003, aggView2502170862885217167, aggJoin4417953249263473839, aggView3759540700435724897, aggJoin7624068694722687955, aggView2479313635270793403, aggJoin5623344103256099372, aggView9212922144455328629, aggJoin6150284473234106904, aggView8785141847638363295, aggJoin5544354300917487679;
