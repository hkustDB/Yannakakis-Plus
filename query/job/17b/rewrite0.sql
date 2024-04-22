create or replace view aggJoin5021119025982788129 as (
with aggView3893427509302418764 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView3893427509302418764 where mc.company_id=aggView3893427509302418764.v20);
create or replace view aggJoin8737354407982504577 as (
with aggView2564728679719449111 as (select v3 from aggJoin5021119025982788129 group by v3)
select id as v3 from title as t, aggView2564728679719449111 where t.id=aggView2564728679719449111.v3);
create or replace view aggJoin2511930630562411003 as (
with aggView7993063559228104673 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7993063559228104673 where mk.keyword_id=aggView7993063559228104673.v25);
create or replace view aggJoin1840160564972012038 as (
with aggView5512464208378113973 as (select v3 from aggJoin2511930630562411003 group by v3)
select v3 from aggJoin8737354407982504577 join aggView5512464208378113973 using(v3));
create or replace view aggJoin6254372127877176199 as (
with aggView423769464367227023 as (select v3 from aggJoin1840160564972012038 group by v3)
select person_id as v26 from cast_info as ci, aggView423769464367227023 where ci.movie_id=aggView423769464367227023.v3);
create or replace view aggJoin2105321896807269043 as (
with aggView604785166999872821 as (select v26 from aggJoin6254372127877176199 group by v26)
select name as v27 from name as n, aggView604785166999872821 where n.id=aggView604785166999872821.v26);
create or replace view aggJoin1351890282125055826 as (
with aggView2157390489963721429 as (select v27 from aggJoin2105321896807269043 group by v27)
select v27 from aggView2157390489963721429 where v27 LIKE 'Z%');
select MIN(v27) as v47 from aggJoin1351890282125055826;
