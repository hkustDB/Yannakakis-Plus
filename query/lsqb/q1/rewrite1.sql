## AggReduce Phase: 

# AggReduce9
# 1. aggView
create or replace view aggView4038715881168113881 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin7823704999283274317 as select CityId as v6, annot from City as City, aggView4038715881168113881 where City.isPartOf_CountryId=aggView4038715881168113881.v4;

# AggReduce10
# 1. aggView
create or replace view aggView7824878589765319522 as select v6, SUM(annot) as annot from aggJoin7823704999283274317 group by v6;
# 2. aggJoin
create or replace view aggJoin2985213472563596296 as select PersonId as v8, annot from Person as Person, aggView7824878589765319522 where Person.isLocatedIn_CityId=aggView7824878589765319522.v6;

# AggReduce11
# 1. aggView
create or replace view aggView4359159238645012765 as select v8, SUM(annot) as annot from aggJoin2985213472563596296 group by v8;
# 2. aggJoin
create or replace view aggJoin5573953470163970071 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView4359159238645012765 where Forum_hasMember_Person.PersonId=aggView4359159238645012765.v8;

# AggReduce12
# 1. aggView
create or replace view aggView3853513241885164149 as select v9, SUM(annot) as annot from aggJoin5573953470163970071 group by v9;
# 2. aggJoin
create or replace view aggJoin4334534039452865204 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView3853513241885164149 where Post.Forum_containerOfId=aggView3853513241885164149.v9;

# AggReduce13
# 1. aggView
create or replace view aggView2586415545016651555 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin246650557046157175 as select v18, aggJoin4334534039452865204.annot * aggView2586415545016651555.annot as annot from aggJoin4334534039452865204 join aggView2586415545016651555 using(v9);

# AggReduce14
# 1. aggView
create or replace view aggView5279282601780314070 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin7476523641878330333 as select TagId as v22, annot from Tag as Tag, aggView5279282601780314070 where Tag.hasType_TagClassId=aggView5279282601780314070.v23;

# AggReduce15
# 1. aggView
create or replace view aggView4898508340907996050 as select v22, SUM(annot) as annot from aggJoin7476523641878330333 group by v22;
# 2. aggJoin
create or replace view aggJoin5041130394078403374 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView4898508340907996050 where Comment_hasTag_Tag.TagId=aggView4898508340907996050.v22;

# AggReduce16
# 1. aggView
create or replace view aggView7604843167383672401 as select v20, SUM(annot) as annot from aggJoin5041130394078403374 group by v20;
# 2. aggJoin
create or replace view aggJoin1005729757624334384 as select replyOf_PostId as v18, annot from Comment as Comment, aggView7604843167383672401 where Comment.CommentId=aggView7604843167383672401.v20;

# AggReduce17
# 1. aggView
create or replace view aggView7591532576700384558 as select v18, SUM(annot) as annot from aggJoin1005729757624334384 group by v18;
# 2. aggJoin
create or replace view aggJoin3987125377592286839 as select aggJoin246650557046157175.annot * aggView7591532576700384558.annot as annot from aggJoin246650557046157175 join aggView7591532576700384558 using(v18);
# Final result: 
select SUM(annot) as v26 from aggJoin3987125377592286839;

# drop view aggView4038715881168113881, aggJoin7823704999283274317, aggView7824878589765319522, aggJoin2985213472563596296, aggView4359159238645012765, aggJoin5573953470163970071, aggView3853513241885164149, aggJoin4334534039452865204, aggView2586415545016651555, aggJoin246650557046157175, aggView5279282601780314070, aggJoin7476523641878330333, aggView4898508340907996050, aggJoin5041130394078403374, aggView7604843167383672401, aggJoin1005729757624334384, aggView7591532576700384558, aggJoin3987125377592286839;
