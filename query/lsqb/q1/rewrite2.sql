## AggReduce Phase: 

# AggReduce18
# 1. aggView
create or replace view aggView6369577442291853864 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin4538368719976200973 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6369577442291853864 where Forum_hasMember_Person.ForumId=aggView6369577442291853864.v9;

# AggReduce19
# 1. aggView
create or replace view aggView3962439697911034325 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin358015894789786971 as select CityId as v6, annot from City as City, aggView3962439697911034325 where City.isPartOf_CountryId=aggView3962439697911034325.v4;

# AggReduce20
# 1. aggView
create or replace view aggView6752690784568436005 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin1649489603052342505 as select TagId as v22, annot from Tag as Tag, aggView6752690784568436005 where Tag.hasType_TagClassId=aggView6752690784568436005.v23;

# AggReduce21
# 1. aggView
create or replace view aggView1137478657439281799 as select v22, SUM(annot) as annot from aggJoin1649489603052342505 group by v22;
# 2. aggJoin
create or replace view aggJoin3520804652433850311 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView1137478657439281799 where Comment_hasTag_Tag.TagId=aggView1137478657439281799.v22;

# AggReduce22
# 1. aggView
create or replace view aggView8286228832698165690 as select v20, SUM(annot) as annot from aggJoin3520804652433850311 group by v20;
# 2. aggJoin
create or replace view aggJoin6525012226377088068 as select replyOf_PostId as v18, annot from Comment as Comment, aggView8286228832698165690 where Comment.CommentId=aggView8286228832698165690.v20;

# AggReduce23
# 1. aggView
create or replace view aggView5185013298055467866 as select v18, SUM(annot) as annot from aggJoin6525012226377088068 group by v18;
# 2. aggJoin
create or replace view aggJoin599238388536142247 as select Forum_containerOfId as v9, annot from Post as Post, aggView5185013298055467866 where Post.PostId=aggView5185013298055467866.v18;

# AggReduce24
# 1. aggView
create or replace view aggView3726903470031805847 as select v9, SUM(annot) as annot from aggJoin599238388536142247 group by v9;
# 2. aggJoin
create or replace view aggJoin3019928837981121782 as select v8, aggJoin4538368719976200973.annot * aggView3726903470031805847.annot as annot from aggJoin4538368719976200973 join aggView3726903470031805847 using(v9);

# AggReduce25
# 1. aggView
create or replace view aggView136406120793308658 as select v8, SUM(annot) as annot from aggJoin3019928837981121782 group by v8;
# 2. aggJoin
create or replace view aggJoin7856467260890497171 as select isLocatedIn_CityId as v6, annot from Person as Person, aggView136406120793308658 where Person.PersonId=aggView136406120793308658.v8;

# AggReduce26
# 1. aggView
create or replace view aggView2184741222029643355 as select v6, SUM(annot) as annot from aggJoin7856467260890497171 group by v6;
# 2. aggJoin
create or replace view aggJoin376489351096458071 as select aggJoin358015894789786971.annot * aggView2184741222029643355.annot as annot from aggJoin358015894789786971 join aggView2184741222029643355 using(v6);
# Final result: 
select SUM(annot) as v26 from aggJoin376489351096458071;

# drop view aggView6369577442291853864, aggJoin4538368719976200973, aggView3962439697911034325, aggJoin358015894789786971, aggView6752690784568436005, aggJoin1649489603052342505, aggView1137478657439281799, aggJoin3520804652433850311, aggView8286228832698165690, aggJoin6525012226377088068, aggView5185013298055467866, aggJoin599238388536142247, aggView3726903470031805847, aggJoin3019928837981121782, aggView136406120793308658, aggJoin7856467260890497171, aggView2184741222029643355, aggJoin376489351096458071;
