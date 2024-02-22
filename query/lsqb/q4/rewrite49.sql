create or replace view aggView7621765610009634934 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5116824908443302903 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7621765610009634934 where Message_hasTag_Tag.MessageId=aggView7621765610009634934.v1;
create or replace view aggView9078790153797624258 as select v1, SUM(annot) as annot from aggJoin5116824908443302903 group by v1;
create or replace view aggJoin3647794889091885973 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView9078790153797624258 where Message_hasCreator_Person.MessageId=aggView9078790153797624258.v1;
create or replace view aggView3519084783909367148 as select v1, SUM(annot) as annot from aggJoin3647794889091885973 group by v1;
create or replace view aggJoin4113520692523781547 as select annot from Person_likes_Message as Person_likes_Message, aggView3519084783909367148 where Person_likes_Message.MessageId=aggView3519084783909367148.v1;
select SUM(annot) as v9 from aggJoin4113520692523781547;
