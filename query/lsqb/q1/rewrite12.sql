## AggReduce Phase: 

# AggReduce108
# 1. aggView
create or replace view aggView6863020517885834876 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin6162696327593224909 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6863020517885834876 where Forum_hasMember_Person.ForumId=aggView6863020517885834876.v9;

# AggReduce109
# 1. aggView
create or replace view aggView8868123006023958842 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin4445597274011222614 as select CityId as v6, annot from City as City, aggView8868123006023958842 where City.isPartOf_CountryId=aggView8868123006023958842.v4;

# AggReduce110
# 1. aggView
create or replace view aggView6180660351101963929 as select v6, SUM(annot) as annot from aggJoin4445597274011222614 group by v6;
# 2. aggJoin
create or replace view aggJoin2271410052010273264 as select PersonId as v8, annot from Person as Person, aggView6180660351101963929 where Person.isLocatedIn_CityId=aggView6180660351101963929.v6;

# AggReduce111
# 1. aggView
create or replace view aggView2712686137099461209 as select v8, SUM(annot) as annot from aggJoin2271410052010273264 group by v8;
# 2. aggJoin
create or replace view aggJoin6898100011408636953 as select v9, aggJoin6162696327593224909.annot * aggView2712686137099461209.annot as annot from aggJoin6162696327593224909 join aggView2712686137099461209 using(v8);

# AggReduce112
# 1. aggView
create or replace view aggView3083484922315068606 as select v9, SUM(annot) as annot from aggJoin6898100011408636953 group by v9;
# 2. aggJoin
create or replace view aggJoin1813049541926872309 as select PostId as v18, annot from Post as Post, aggView3083484922315068606 where Post.Forum_containerOfId=aggView3083484922315068606.v9;

# AggReduce113
# 1. aggView
create or replace view aggView1687031057511039368 as select v18, SUM(annot) as annot from aggJoin1813049541926872309 group by v18;
# 2. aggJoin
create or replace view aggJoin1851594419307121268 as select CommentId as v20, annot from Comment as Comment, aggView1687031057511039368 where Comment.replyOf_PostId=aggView1687031057511039368.v18;

# AggReduce114
# 1. aggView
create or replace view aggView6472349221885991995 as select v20, SUM(annot) as annot from aggJoin1851594419307121268 group by v20;
# 2. aggJoin
create or replace view aggJoin245734444380445208 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView6472349221885991995 where Comment_hasTag_Tag.CommentId=aggView6472349221885991995.v20;

# AggReduce115
# 1. aggView
create or replace view aggView8735072481223908567 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin6084807326695835692 as select TagId as v22, annot from Tag as Tag, aggView8735072481223908567 where Tag.hasType_TagClassId=aggView8735072481223908567.v23;

# AggReduce116
# 1. aggView
create or replace view aggView4900748143071754092 as select v22, SUM(annot) as annot from aggJoin6084807326695835692 group by v22;
# 2. aggJoin
create or replace view aggJoin6086336537342985318 as select aggJoin245734444380445208.annot * aggView4900748143071754092.annot as annot from aggJoin245734444380445208 join aggView4900748143071754092 using(v22);
# Final result: 
select SUM(annot) as v26 from aggJoin6086336537342985318;

# drop view aggView6863020517885834876, aggJoin6162696327593224909, aggView8868123006023958842, aggJoin4445597274011222614, aggView6180660351101963929, aggJoin2271410052010273264, aggView2712686137099461209, aggJoin6898100011408636953, aggView3083484922315068606, aggJoin1813049541926872309, aggView1687031057511039368, aggJoin1851594419307121268, aggView6472349221885991995, aggJoin245734444380445208, aggView8735072481223908567, aggJoin6084807326695835692, aggView4900748143071754092, aggJoin6086336537342985318;
