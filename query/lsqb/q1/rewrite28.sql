## AggReduce Phase: 

# AggReduce252
# 1. aggView
create or replace view aggView5392839794589471587 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin985316990105614364 as select CityId as v6, annot from City as City, aggView5392839794589471587 where City.isPartOf_CountryId=aggView5392839794589471587.v4;

# AggReduce253
# 1. aggView
create or replace view aggView3388149903969685392 as select v6, SUM(annot) as annot from aggJoin985316990105614364 group by v6;
# 2. aggJoin
create or replace view aggJoin5286385168414512450 as select PersonId as v8, annot from Person as Person, aggView3388149903969685392 where Person.isLocatedIn_CityId=aggView3388149903969685392.v6;

# AggReduce254
# 1. aggView
create or replace view aggView3644961620765224110 as select v8, SUM(annot) as annot from aggJoin5286385168414512450 group by v8;
# 2. aggJoin
create or replace view aggJoin8274495501603881211 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView3644961620765224110 where Forum_hasMember_Person.PersonId=aggView3644961620765224110.v8;

# AggReduce255
# 1. aggView
create or replace view aggView78712218625797330 as select v9, SUM(annot) as annot from aggJoin8274495501603881211 group by v9;
# 2. aggJoin
create or replace view aggJoin3421502231501264402 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView78712218625797330 where Post.Forum_containerOfId=aggView78712218625797330.v9;

# AggReduce256
# 1. aggView
create or replace view aggView1216142679689294680 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin1886068854268488511 as select v18, aggJoin3421502231501264402.annot * aggView1216142679689294680.annot as annot from aggJoin3421502231501264402 join aggView1216142679689294680 using(v9);

# AggReduce257
# 1. aggView
create or replace view aggView4016578281481090892 as select v18, SUM(annot) as annot from aggJoin1886068854268488511 group by v18;
# 2. aggJoin
create or replace view aggJoin3372531437604119410 as select CommentId as v20, annot from Comment as Comment, aggView4016578281481090892 where Comment.replyOf_PostId=aggView4016578281481090892.v18;

# AggReduce258
# 1. aggView
create or replace view aggView5146509069517686494 as select v20, SUM(annot) as annot from aggJoin3372531437604119410 group by v20;
# 2. aggJoin
create or replace view aggJoin5018509197959721974 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView5146509069517686494 where Comment_hasTag_Tag.CommentId=aggView5146509069517686494.v20;

# AggReduce259
# 1. aggView
create or replace view aggView7808671753890067342 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin6211519155401691960 as select TagId as v22, annot from Tag as Tag, aggView7808671753890067342 where Tag.hasType_TagClassId=aggView7808671753890067342.v23;

# AggReduce260
# 1. aggView
create or replace view aggView19373750667180545 as select v22, SUM(annot) as annot from aggJoin6211519155401691960 group by v22;
# 2. aggJoin
create or replace view aggJoin3181894911299701862 as select aggJoin5018509197959721974.annot * aggView19373750667180545.annot as annot from aggJoin5018509197959721974 join aggView19373750667180545 using(v22);
# Final result: 
select SUM(annot) as v26 from aggJoin3181894911299701862;

# drop view aggView5392839794589471587, aggJoin985316990105614364, aggView3388149903969685392, aggJoin5286385168414512450, aggView3644961620765224110, aggJoin8274495501603881211, aggView78712218625797330, aggJoin3421502231501264402, aggView1216142679689294680, aggJoin1886068854268488511, aggView4016578281481090892, aggJoin3372531437604119410, aggView5146509069517686494, aggJoin5018509197959721974, aggView7808671753890067342, aggJoin6211519155401691960, aggView19373750667180545, aggJoin3181894911299701862;
