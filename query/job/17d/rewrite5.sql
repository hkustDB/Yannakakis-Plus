create or replace view aggJoin5897853743363287754 as (
with aggView1464739290813018280 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1464739290813018280 where mc.company_id=aggView1464739290813018280.v20);
create or replace view aggJoin3840343035830327527 as (
with aggView6566209282846733403 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView6566209282846733403 where ci.movie_id=aggView6566209282846733403.v3);
create or replace view aggJoin7021636863872345008 as (
with aggView545065925620396131 as (select v3 from aggJoin5897853743363287754 group by v3)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView545065925620396131 where mk.movie_id=aggView545065925620396131.v3);
create or replace view aggJoin4427016139165054172 as (
with aggView8748552996353592661 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin7021636863872345008 join aggView8748552996353592661 using(v25));
create or replace view aggJoin2680798509363000715 as (
with aggView5896633525993294782 as (select v3 from aggJoin4427016139165054172 group by v3)
select v26 from aggJoin3840343035830327527 join aggView5896633525993294782 using(v3));
create or replace view aggJoin4330981143428999235 as (
with aggView612128093525279610 as (select v26 from aggJoin2680798509363000715 group by v26)
select name as v27 from name as n, aggView612128093525279610 where n.id=aggView612128093525279610.v26);
create or replace view aggJoin1888851664259080038 as (
with aggView3985355671863123175 as (select v27 from aggJoin4330981143428999235 group by v27)
select v27 from aggView3985355671863123175 where v27 LIKE '%Bert%');
select MIN(v27) as v47 from aggJoin1888851664259080038;
