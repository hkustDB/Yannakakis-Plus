create or replace view aggJoin3195002265134444786 as (
with aggView8158727772357009304 as (select id as v26, name as v47 from name as n)
select movie_id as v3, v47 from cast_info as ci, aggView8158727772357009304 where ci.person_id=aggView8158727772357009304.v26);
create or replace view aggJoin7929673713570391633 as (
with aggView5899066113965955735 as (select id as v3 from title as t)
select v3, v47 from aggJoin3195002265134444786 join aggView5899066113965955735 using(v3));
create or replace view aggJoin2304399799661258391 as (
with aggView7860326891055986674 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView7860326891055986674 where mc.company_id=aggView7860326891055986674.v20);
create or replace view aggJoin8335269634212874243 as (
with aggView8080466530737961502 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8080466530737961502 where mk.keyword_id=aggView8080466530737961502.v25);
create or replace view aggJoin8402307084074994030 as (
with aggView1082339348276451581 as (select v3 from aggJoin2304399799661258391 group by v3)
select v3 from aggJoin8335269634212874243 join aggView1082339348276451581 using(v3));
create or replace view aggJoin5893604156915193524 as (
with aggView779554654916708240 as (select v3 from aggJoin8402307084074994030 group by v3)
select v47 as v47 from aggJoin7929673713570391633 join aggView779554654916708240 using(v3));
select MIN(v47) as v47 from aggJoin5893604156915193524;
