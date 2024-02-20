## AggReduce Phase: 

# AggReduce54
# 1. aggView
create or replace view aggView9098870131166850873 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin7860046811021234529 as select CityId as v6, annot from City as City, aggView9098870131166850873 where City.isPartOf_CountryId=aggView9098870131166850873.v4;

# AggReduce55
# 1. aggView
create or replace view aggView8457308796835792104 as select v6, SUM(annot) as annot from aggJoin7860046811021234529 group by v6;
# 2. aggJoin
create or replace view aggJoin1660717972843481603 as select PersonId as v8, annot from Person as Person, aggView8457308796835792104 where Person.isLocatedIn_CityId=aggView8457308796835792104.v6;

# AggReduce56
# 1. aggView
create or replace view aggView6201417363488181187 as select v8, SUM(annot) as annot from aggJoin1660717972843481603 group by v8;
# 2. aggJoin
create or replace view aggJoin8121427605538048638 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6201417363488181187 where Forum_hasMember_Person.PersonId=aggView6201417363488181187.v8;

# AggReduce57
# 1. aggView
create or replace view aggView683567045814011240 as select v9, SUM(annot) as annot from aggJoin8121427605538048638 group by v9;
# 2. aggJoin
create or replace view aggJoin2234496587759340416 as select ForumId as v9, annot from Forum as Forum, aggView683567045814011240 where Forum.ForumId=aggView683567045814011240.v9;

# AggReduce58
# 1. aggView
create or replace view aggView2079537099200796512 as select v9, SUM(annot) as annot from aggJoin2234496587759340416 group by v9;
# 2. aggJoin
create or replace view aggJoin7445287436423663301 as select PostId as v18, annot from Post as Post, aggView2079537099200796512 where Post.Forum_containerOfId=aggView2079537099200796512.v9;

# AggReduce59
# 1. aggView
create or replace view aggView8995353487079179115 as select v18, SUM(annot) as annot from aggJoin7445287436423663301 group by v18;
# 2. aggJoin
create or replace view aggJoin3439020530862249984 as select CommentId as v20, annot from Comment as Comment, aggView8995353487079179115 where Comment.replyOf_PostId=aggView8995353487079179115.v18;

# AggReduce60
# 1. aggView
create or replace view aggView3564521202301249847 as select v20, SUM(annot) as annot from aggJoin3439020530862249984 group by v20;
# 2. aggJoin
create or replace view aggJoin733404592436976125 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView3564521202301249847 where Comment_hasTag_Tag.CommentId=aggView3564521202301249847.v20;

# AggReduce61
# 1. aggView
create or replace view aggView7744853941643193136 as select v22, SUM(annot) as annot from aggJoin733404592436976125 group by v22;
# 2. aggJoin
create or replace view aggJoin3507473570933116909 as select hasType_TagClassId as v23, annot from Tag as Tag, aggView7744853941643193136 where Tag.TagId=aggView7744853941643193136.v22;

# AggReduce62
# 1. aggView
create or replace view aggView8145390766894682956 as select v23, SUM(annot) as annot from aggJoin3507473570933116909 group by v23;
# 2. aggJoin
create or replace view aggJoin6198623858593294336 as select annot from TagClass as TagClass, aggView8145390766894682956 where TagClass.TagClassId=aggView8145390766894682956.v23;
# Final result: 
select SUM(annot) as v26 from aggJoin6198623858593294336;

# drop view aggView9098870131166850873, aggJoin7860046811021234529, aggView8457308796835792104, aggJoin1660717972843481603, aggView6201417363488181187, aggJoin8121427605538048638, aggView683567045814011240, aggJoin2234496587759340416, aggView2079537099200796512, aggJoin7445287436423663301, aggView8995353487079179115, aggJoin3439020530862249984, aggView3564521202301249847, aggJoin733404592436976125, aggView7744853941643193136, aggJoin3507473570933116909, aggView8145390766894682956, aggJoin6198623858593294336;
