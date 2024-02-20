## AggReduce Phase: 

# AggReduce72
# 1. aggView
create or replace view aggView3552015568579602304 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin6194448761549433947 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3552015568579602304 where Message_hasCreator_Person.MessageId=aggView3552015568579602304.v1;

# AggReduce73
# 1. aggView
create or replace view aggView462383573232462940 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8305347652629492009 as select v1, aggJoin6194448761549433947.annot * aggView462383573232462940.annot as annot from aggJoin6194448761549433947 join aggView462383573232462940 using(v1);

# AggReduce74
# 1. aggView
create or replace view aggView3369812510288660853 as select v1, SUM(annot) as annot from aggJoin8305347652629492009 group by v1;
# 2. aggJoin
create or replace view aggJoin8744939792484096593 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3369812510288660853 where Message_hasTag_Tag.MessageId=aggView3369812510288660853.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin8744939792484096593;

# drop view aggView3552015568579602304, aggJoin6194448761549433947, aggView462383573232462940, aggJoin8305347652629492009, aggView3369812510288660853, aggJoin8744939792484096593;
