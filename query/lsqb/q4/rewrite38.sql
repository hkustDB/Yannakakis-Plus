## AggReduce Phase: 

# AggReduce114
# 1. aggView
create or replace view aggView3403427435579211492 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8811691493581984334 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3403427435579211492 where Message_hasCreator_Person.MessageId=aggView3403427435579211492.v1;

# AggReduce115
# 1. aggView
create or replace view aggView6759915809070857592 as select v1, SUM(annot) as annot from aggJoin8811691493581984334 group by v1;
# 2. aggJoin
create or replace view aggJoin1757015341973876513 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6759915809070857592 where Message_hasTag_Tag.MessageId=aggView6759915809070857592.v1;

# AggReduce116
# 1. aggView
create or replace view aggView2023218313927952820 as select v1, SUM(annot) as annot from aggJoin1757015341973876513 group by v1;
# 2. aggJoin
create or replace view aggJoin2373011748951186744 as select annot from Person_likes_Message as Person_likes_Message, aggView2023218313927952820 where Person_likes_Message.MessageId=aggView2023218313927952820.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2373011748951186744;

# drop view aggView3403427435579211492, aggJoin8811691493581984334, aggView6759915809070857592, aggJoin1757015341973876513, aggView2023218313927952820, aggJoin2373011748951186744;
