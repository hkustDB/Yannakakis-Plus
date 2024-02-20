## AggReduce Phase: 

# AggReduce189
# 1. aggView
create or replace view aggView4676282912991752196 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4008056228619622410 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4676282912991752196 where Message_hasCreator_Person.MessageId=aggView4676282912991752196.v1;

# AggReduce190
# 1. aggView
create or replace view aggView625106450478732535 as select v1, SUM(annot) as annot from aggJoin4008056228619622410 group by v1;
# 2. aggJoin
create or replace view aggJoin7591591602533950328 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView625106450478732535 where Person_likes_Message.MessageId=aggView625106450478732535.v1;

# AggReduce191
# 1. aggView
create or replace view aggView141472401761083153 as select v1, SUM(annot) as annot from aggJoin7591591602533950328 group by v1;
# 2. aggJoin
create or replace view aggJoin6718385037697744548 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView141472401761083153 where Message_hasTag_Tag.MessageId=aggView141472401761083153.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6718385037697744548;

# drop view aggView4676282912991752196, aggJoin4008056228619622410, aggView625106450478732535, aggJoin7591591602533950328, aggView141472401761083153, aggJoin6718385037697744548;
