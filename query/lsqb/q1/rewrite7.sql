## AggReduce Phase: 

# AggReduce63
# 1. aggView
create or replace view aggView1539932119245581538 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin3385792044100694305 as select CityId as v6, annot from City as City, aggView1539932119245581538 where City.isPartOf_CountryId=aggView1539932119245581538.v4;

# AggReduce64
# 1. aggView
create or replace view aggView7775641764338196863 as select v6, SUM(annot) as annot from aggJoin3385792044100694305 group by v6;
# 2. aggJoin
create or replace view aggJoin7148074338480171161 as select PersonId as v8, annot from Person as Person, aggView7775641764338196863 where Person.isLocatedIn_CityId=aggView7775641764338196863.v6;

# AggReduce65
# 1. aggView
create or replace view aggView7252673483410715373 as select v8, SUM(annot) as annot from aggJoin7148074338480171161 group by v8;
# 2. aggJoin
create or replace view aggJoin3209004065237283860 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView7252673483410715373 where Forum_hasMember_Person.PersonId=aggView7252673483410715373.v8;

# AggReduce66
# 1. aggView
create or replace view aggView5214244712211321806 as select v9, SUM(annot) as annot from aggJoin3209004065237283860 group by v9;
# 2. aggJoin
create or replace view aggJoin4146669254377761004 as select ForumId as v9, annot from Forum as Forum, aggView5214244712211321806 where Forum.ForumId=aggView5214244712211321806.v9;

# AggReduce67
# 1. aggView
create or replace view aggView4765788992951288368 as select v9, SUM(annot) as annot from aggJoin4146669254377761004 group by v9;
# 2. aggJoin
create or replace view aggJoin4724875734041252472 as select PostId as v18, annot from Post as Post, aggView4765788992951288368 where Post.Forum_containerOfId=aggView4765788992951288368.v9;

# AggReduce68
# 1. aggView
create or replace view aggView4648754174922359625 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin5862245189706303240 as select TagId as v22, annot from Tag as Tag, aggView4648754174922359625 where Tag.hasType_TagClassId=aggView4648754174922359625.v23;

# AggReduce69
# 1. aggView
create or replace view aggView8932157745182245050 as select v22, SUM(annot) as annot from aggJoin5862245189706303240 group by v22;
# 2. aggJoin
create or replace view aggJoin8684876920403627516 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView8932157745182245050 where Comment_hasTag_Tag.TagId=aggView8932157745182245050.v22;

# AggReduce70
# 1. aggView
create or replace view aggView1780398865356661349 as select v20, SUM(annot) as annot from aggJoin8684876920403627516 group by v20;
# 2. aggJoin
create or replace view aggJoin6610539516536034973 as select replyOf_PostId as v18, annot from Comment as Comment, aggView1780398865356661349 where Comment.CommentId=aggView1780398865356661349.v20;

# AggReduce71
# 1. aggView
create or replace view aggView8752402000837847627 as select v18, SUM(annot) as annot from aggJoin6610539516536034973 group by v18;
# 2. aggJoin
create or replace view aggJoin6637980376934113097 as select aggJoin4724875734041252472.annot * aggView8752402000837847627.annot as annot from aggJoin4724875734041252472 join aggView8752402000837847627 using(v18);
# Final result: 
select SUM(annot) as v26 from aggJoin6637980376934113097;

# drop view aggView1539932119245581538, aggJoin3385792044100694305, aggView7775641764338196863, aggJoin7148074338480171161, aggView7252673483410715373, aggJoin3209004065237283860, aggView5214244712211321806, aggJoin4146669254377761004, aggView4765788992951288368, aggJoin4724875734041252472, aggView4648754174922359625, aggJoin5862245189706303240, aggView8932157745182245050, aggJoin8684876920403627516, aggView1780398865356661349, aggJoin6610539516536034973, aggView8752402000837847627, aggJoin6637980376934113097;
