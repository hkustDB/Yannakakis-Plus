create or replace view aggView3673246245150842884 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggJoin3468535609044347723 as (
with aggView7718510698284982223 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView7718510698284982223 where n.id=aggView7718510698284982223.v42 and gender= 'f');
create or replace view aggView4697154171049188275 as select v42, v43 from aggJoin3468535609044347723 group by v42,v43;
create or replace view aggJoin4255281375954500041 as (
with aggView8347463253372284644 as (select v42, MIN(v43) as v65 from aggView4697154171049188275 group by v42)
select movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v65 from cast_info as ci, aggView8347463253372284644 where ci.person_id=aggView8347463253372284644.v42 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8932057321775080190 as (
with aggView7044693293967015599 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView7044693293967015599 where mc.company_id=aggView7044693293967015599.v23);
create or replace view aggJoin8842073384256493986 as (
with aggView6678307756692213719 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53 from movie_info as mi, aggView6678307756692213719 where mi.info_type_id=aggView6678307756692213719.v30);
create or replace view aggJoin7900060360554596819 as (
with aggView6482573777970686815 as (select id as v51 from role_type as rt where role= 'actress')
select v53, v9, v20, v65 from aggJoin4255281375954500041 join aggView6482573777970686815 using(v51));
create or replace view aggJoin4281762526260076574 as (
with aggView2572246898527186556 as (select v53 from aggJoin8932057321775080190 group by v53)
select v53 from aggJoin8842073384256493986 join aggView2572246898527186556 using(v53));
create or replace view aggJoin521406356146860866 as (
with aggView4485255585009994753 as (select v53 from aggJoin4281762526260076574 group by v53)
select v53, v9, v20, v65 as v65 from aggJoin7900060360554596819 join aggView4485255585009994753 using(v53));
create or replace view aggJoin7099519479364251351 as (
with aggView3473339306211692582 as (select id as v9 from char_name as chn)
select v53, v20, v65 from aggJoin521406356146860866 join aggView3473339306211692582 using(v9));
create or replace view aggJoin4930642465968036131 as (
with aggView6549239444331158620 as (select v53, MIN(v65) as v65 from aggJoin7099519479364251351 group by v53,v65)
select v54, v65 from aggView3673246245150842884 join aggView6549239444331158620 using(v53));
select MIN(v65) as v65,MIN(v54) as v66 from aggJoin4930642465968036131;
