create or replace view aggView5504281753502745770 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2538435314737431279 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5504281753502745770 where Message_hasTag_Tag.MessageId=aggView5504281753502745770.v1;
create or replace view aggView7686640676337731870 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2402571342494515284 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7686640676337731870 where Message_hasCreator_Person.MessageId=aggView7686640676337731870.v1;
create or replace view aggView4987034352163287964 as select v1, SUM(annot) as annot from aggJoin2402571342494515284 group by v1;
create or replace view aggJoin4886679823812799035 as select aggJoin2538435314737431279.annot * aggView4987034352163287964.annot as annot from aggJoin2538435314737431279 join aggView4987034352163287964 using(v1);
select SUM(annot) as v9 from aggJoin4886679823812799035;
