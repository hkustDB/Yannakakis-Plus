## AggReduce Phase: 

# AggReduce171
# 1. aggView
create or replace view aggView5659626459284159991 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin2289696093243275199 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5659626459284159991 where Message_hasCreator_Person.MessageId=aggView5659626459284159991.v1;

# AggReduce172
# 1. aggView
create or replace view aggView1911768133876390238 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin8252046256663450899 as select v1, aggJoin2289696093243275199.annot * aggView1911768133876390238.annot as annot from aggJoin2289696093243275199 join aggView1911768133876390238 using(v1);

# AggReduce173
# 1. aggView
create or replace view aggView196908722522418651 as select v1, SUM(annot) as annot from aggJoin8252046256663450899 group by v1;
# 2. aggJoin
create or replace view aggJoin6703034602253508145 as select annot from Person_likes_Message as Person_likes_Message, aggView196908722522418651 where Person_likes_Message.MessageId=aggView196908722522418651.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6703034602253508145;

# drop view aggView5659626459284159991, aggJoin2289696093243275199, aggView1911768133876390238, aggJoin8252046256663450899, aggView196908722522418651, aggJoin6703034602253508145;
