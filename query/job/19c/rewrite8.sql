create or replace view aggView4438199508989563790 as select id as v53, title as v54 from title as t where production_year>2000;
create or replace view aggJoin3959246211347201256 as (
with aggView6006199524760932603 as (select person_id as v42 from aka_name as an group by person_id)
select id as v42, name as v43, gender as v46 from name as n, aggView6006199524760932603 where n.id=aggView6006199524760932603.v42 and name LIKE '%An%' and gender= 'f');
create or replace view aggView2397133006108726375 as select v43, v42 from aggJoin3959246211347201256 group by v43,v42;
create or replace view aggJoin1600501980786511349 as (
with aggView8608531572753689711 as (select v53, MIN(v54) as v66 from aggView4438199508989563790 group by v53)
select person_id as v42, movie_id as v53, person_role_id as v9, note as v20, role_id as v51, v66 from cast_info as ci, aggView8608531572753689711 where ci.movie_id=aggView8608531572753689711.v53 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3194342512307608021 as (
with aggView7358751988033715021 as (select id as v51 from role_type as rt where role= 'actress')
select v42, v53, v9, v20, v66 from aggJoin1600501980786511349 join aggView7358751988033715021 using(v51));
create or replace view aggJoin6393553209473605995 as (
with aggView5657181531377013630 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v53, info as v40 from movie_info as mi, aggView5657181531377013630 where mi.info_type_id=aggView5657181531377013630.v30 and ((info LIKE 'Japan:%200%') OR (info LIKE 'USA:%200%')));
create or replace view aggJoin2443817865420799160 as (
with aggView4242017685150234072 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v53 from movie_companies as mc, aggView4242017685150234072 where mc.company_id=aggView4242017685150234072.v23);
create or replace view aggJoin3357482960073429687 as (
with aggView6621236229629298014 as (select v53 from aggJoin2443817865420799160 group by v53)
select v53, v40 from aggJoin6393553209473605995 join aggView6621236229629298014 using(v53));
create or replace view aggJoin6614426890009006858 as (
with aggView3164008899304839020 as (select v53 from aggJoin3357482960073429687 group by v53)
select v42, v9, v20, v66 as v66 from aggJoin3194342512307608021 join aggView3164008899304839020 using(v53));
create or replace view aggJoin8589556778255840378 as (
with aggView4359536974119959582 as (select id as v9 from char_name as chn)
select v42, v20, v66 from aggJoin6614426890009006858 join aggView4359536974119959582 using(v9));
create or replace view aggJoin2331351506553724056 as (
with aggView7550528579687461136 as (select v42, MIN(v66) as v66 from aggJoin8589556778255840378 group by v42,v66)
select v43, v66 from aggView2397133006108726375 join aggView7550528579687461136 using(v42));
select MIN(v43) as v65,MIN(v66) as v66 from aggJoin2331351506553724056;
