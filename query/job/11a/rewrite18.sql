create or replace view aggJoin4022799790629162591 as (
with aggView5523571462473438561 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView5523571462473438561 where mc.company_id=aggView5523571462473438561.v17);
create or replace view aggJoin8260367347029272601 as (
with aggView5850318311113276842 as (select id as v24, title as v41 from title as t where production_year<=2000 and production_year>=1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView5850318311113276842 where ml.movie_id=aggView5850318311113276842.v24);
create or replace view aggJoin4358203391241085944 as (
with aggView5735858815137372625 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follow%')
select v24, v41, v40 from aggJoin8260367347029272601 join aggView5735858815137372625 using(v13));
create or replace view aggJoin5875184704714364190 as (
with aggView1169893491402463148 as (select v24, MIN(v41) as v41, MIN(v40) as v40 from aggJoin4358203391241085944 group by v24,v40,v41)
select movie_id as v24, keyword_id as v22, v41, v40 from movie_keyword as mk, aggView1169893491402463148 where mk.movie_id=aggView1169893491402463148.v24);
create or replace view aggJoin5873832841063346839 as (
with aggView1473409176170104736 as (select id as v22 from keyword as k where keyword= 'sequel')
select v24, v41, v40 from aggJoin5875184704714364190 join aggView1473409176170104736 using(v22));
create or replace view aggJoin1094492742495141633 as (
with aggView7626561007700159365 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin4022799790629162591 join aggView7626561007700159365 using(v18));
create or replace view aggJoin9006572047328337632 as (
with aggView9095572257739500143 as (select v24, MIN(v39) as v39 from aggJoin1094492742495141633 group by v24,v39)
select v41 as v41, v40 as v40, v39 from aggJoin5873832841063346839 join aggView9095572257739500143 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin9006572047328337632;
