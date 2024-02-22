create or replace view aggView6594401196692495131 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6789242952777376292 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6594401196692495131 where Message_hasTag_Tag.MessageId=aggView6594401196692495131.v1;
create or replace view aggView2759289993933749936 as select v1, SUM(annot) as annot from aggJoin6789242952777376292 group by v1;
create or replace view aggJoin7642535222622319838 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2759289993933749936 where Person_likes_Message.MessageId=aggView2759289993933749936.v1;
create or replace view aggView6105467089376684860 as select v1, SUM(annot) as annot from aggJoin7642535222622319838 group by v1;
create or replace view aggJoin5668159705498780493 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6105467089376684860 where Message_hasCreator_Person.MessageId=aggView6105467089376684860.v1;
select SUM(annot) as v9 from aggJoin5668159705498780493;
