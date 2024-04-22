create or replace view aggJoin99615795266030312 as (
with aggView6967867748406579787 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6967867748406579787 where mk.keyword_id=aggView6967867748406579787.v25);
create or replace view aggJoin3733756545591951575 as (
with aggView5640918127421000409 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView5640918127421000409 where mc.company_id=aggView5640918127421000409.v20);
create or replace view aggJoin1216250399680497774 as (
with aggView7226316973640230188 as (select v3 from aggJoin3733756545591951575 group by v3)
select v3 from aggJoin99615795266030312 join aggView7226316973640230188 using(v3));
create or replace view aggJoin5025329880043856239 as (
with aggView4852377818736387049 as (select v3 from aggJoin1216250399680497774 group by v3)
select id as v3 from title as t, aggView4852377818736387049 where t.id=aggView4852377818736387049.v3);
create or replace view aggJoin1286720068334656779 as (
with aggView1216581792916958560 as (select v3 from aggJoin5025329880043856239 group by v3)
select person_id as v26 from cast_info as ci, aggView1216581792916958560 where ci.movie_id=aggView1216581792916958560.v3);
create or replace view aggJoin4822412486550334733 as (
with aggView4647415648867210227 as (select v26 from aggJoin1286720068334656779 group by v26)
select name as v27 from name as n, aggView4647415648867210227 where n.id=aggView4647415648867210227.v26 and name LIKE '%B%');
create or replace view aggView7080030222354198702 as select v27 from aggJoin4822412486550334733 group by v27;
select MIN(v27) as v47 from aggView7080030222354198702;
