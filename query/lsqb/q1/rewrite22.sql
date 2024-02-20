## AggReduce Phase: 

# AggReduce198
# 1. aggView
create or replace view aggView1595754559114108042 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin3869764571563334046 as select CityId as v6, annot from City as City, aggView1595754559114108042 where City.isPartOf_CountryId=aggView1595754559114108042.v4;

# AggReduce199
# 1. aggView
create or replace view aggView1053257613566207779 as select v6, SUM(annot) as annot from aggJoin3869764571563334046 group by v6;
# 2. aggJoin
create or replace view aggJoin5842901768696728323 as select PersonId as v8, annot from Person as Person, aggView1053257613566207779 where Person.isLocatedIn_CityId=aggView1053257613566207779.v6;

# AggReduce200
# 1. aggView
create or replace view aggView7854931194625150437 as select v8, SUM(annot) as annot from aggJoin5842901768696728323 group by v8;
# 2. aggJoin
create or replace view aggJoin8717970893687653949 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView7854931194625150437 where Forum_hasMember_Person.PersonId=aggView7854931194625150437.v8;

# AggReduce201
# 1. aggView
create or replace view aggView8181161327549484077 as select v9, SUM(annot) as annot from aggJoin8717970893687653949 group by v9;
# 2. aggJoin
create or replace view aggJoin3260082473036846515 as select ForumId as v9, annot from Forum as Forum, aggView8181161327549484077 where Forum.ForumId=aggView8181161327549484077.v9;

# AggReduce202
# 1. aggView
create or replace view aggView4045566348935486757 as select v9, SUM(annot) as annot from aggJoin3260082473036846515 group by v9;
# 2. aggJoin
create or replace view aggJoin3097963698901700697 as select PostId as v18, annot from Post as Post, aggView4045566348935486757 where Post.Forum_containerOfId=aggView4045566348935486757.v9;

# AggReduce203
# 1. aggView
create or replace view aggView7906083620773758686 as select v18, SUM(annot) as annot from aggJoin3097963698901700697 group by v18;
# 2. aggJoin
create or replace view aggJoin774964265800862535 as select CommentId as v20, annot from Comment as Comment, aggView7906083620773758686 where Comment.replyOf_PostId=aggView7906083620773758686.v18;

# AggReduce204
# 1. aggView
create or replace view aggView5142670258662086398 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin1299966712241749836 as select TagId as v22, annot from Tag as Tag, aggView5142670258662086398 where Tag.hasType_TagClassId=aggView5142670258662086398.v23;

# AggReduce205
# 1. aggView
create or replace view aggView7812886681308672779 as select v22, SUM(annot) as annot from aggJoin1299966712241749836 group by v22;
# 2. aggJoin
create or replace view aggJoin5875452688207091935 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView7812886681308672779 where Comment_hasTag_Tag.TagId=aggView7812886681308672779.v22;

# AggReduce206
# 1. aggView
create or replace view aggView893473353221495235 as select v20, SUM(annot) as annot from aggJoin5875452688207091935 group by v20;
# 2. aggJoin
create or replace view aggJoin6032628475409763038 as select aggJoin774964265800862535.annot * aggView893473353221495235.annot as annot from aggJoin774964265800862535 join aggView893473353221495235 using(v20);
# Final result: 
select SUM(annot) as v26 from aggJoin6032628475409763038;

# drop view aggView1595754559114108042, aggJoin3869764571563334046, aggView1053257613566207779, aggJoin5842901768696728323, aggView7854931194625150437, aggJoin8717970893687653949, aggView8181161327549484077, aggJoin3260082473036846515, aggView4045566348935486757, aggJoin3097963698901700697, aggView7906083620773758686, aggJoin774964265800862535, aggView5142670258662086398, aggJoin1299966712241749836, aggView7812886681308672779, aggJoin5875452688207091935, aggView893473353221495235, aggJoin6032628475409763038;
