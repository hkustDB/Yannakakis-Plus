create or replace view aggJoin4694040222359492505 as (
with aggView6048503899984525230 as (select id as v48, name as v49 from name as n where gender= 'f')
select v48, v49 from aggView6048503899984525230 where v49 LIKE '%An%');
create or replace view aggView1242879572529518921 as select name as v10, id as v9 from char_name as chn;
create or replace view aggView8947505562864771818 as select id as v59, title as v60 from title as t where production_year>2010;
create or replace view aggJoin898411500095943433 as (
with aggView388313464827179660 as (select v59, MIN(v60) as v73 from aggView8947505562864771818 group by v59)
select person_id as v48, movie_id as v59, person_role_id as v9, note as v20, role_id as v57, v73 from cast_info as ci, aggView388313464827179660 where ci.movie_id=aggView388313464827179660.v59 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin8131749430640755456 as (
with aggView8651195260193134726 as (select v9, MIN(v10) as v71 from aggView1242879572529518921 group by v9)
select v48, v59, v20, v57, v73 as v73, v71 from aggJoin898411500095943433 join aggView8651195260193134726 using(v9));
create or replace view aggJoin1443768521953902463 as (
with aggView7538163891062469379 as (select id as v30 from info_type as it where info= 'release dates')
select movie_id as v59, info as v43 from movie_info as mi, aggView7538163891062469379 where mi.info_type_id=aggView7538163891062469379.v30 and ((info LIKE 'Japan:%201%') OR (info LIKE 'USA:%201%')));
create or replace view aggJoin5256163105859349878 as (
with aggView8819439777449038676 as (select id as v23 from company_name as cn where country_code= '[us]')
select movie_id as v59 from movie_companies as mc, aggView8819439777449038676 where mc.company_id=aggView8819439777449038676.v23);
create or replace view aggJoin2572797669502822969 as (
with aggView8299590972544225632 as (select person_id as v48 from aka_name as an group by person_id)
select v48, v59, v20, v57, v73 as v73, v71 as v71 from aggJoin8131749430640755456 join aggView8299590972544225632 using(v48));
create or replace view aggJoin4268992610180511600 as (
with aggView5998408938512091414 as (select v59 from aggJoin5256163105859349878 group by v59)
select v59, v43 from aggJoin1443768521953902463 join aggView5998408938512091414 using(v59));
create or replace view aggJoin5627356809561876892 as (
with aggView3820821168064875660 as (select v59 from aggJoin4268992610180511600 group by v59)
select movie_id as v59, keyword_id as v32 from movie_keyword as mk, aggView3820821168064875660 where mk.movie_id=aggView3820821168064875660.v59);
create or replace view aggJoin8268609225375993686 as (
with aggView6670102633720198004 as (select id as v57 from role_type as rt where role= 'actress')
select v48, v59, v20, v73, v71 from aggJoin2572797669502822969 join aggView6670102633720198004 using(v57));
create or replace view aggJoin819060967640193975 as (
with aggView5179846908155982151 as (select id as v32 from keyword as k where keyword IN ('hero','martial-arts','hand-to-hand-combat'))
select v59 from aggJoin5627356809561876892 join aggView5179846908155982151 using(v32));
create or replace view aggJoin5129039314780369691 as (
with aggView3148333785358415958 as (select v59 from aggJoin819060967640193975 group by v59)
select v48, v20, v73 as v73, v71 as v71 from aggJoin8268609225375993686 join aggView3148333785358415958 using(v59));
create or replace view aggJoin7159800393727090614 as (
with aggView6734723446262181314 as (select v48, MIN(v73) as v73, MIN(v71) as v71 from aggJoin5129039314780369691 group by v48,v73,v71)
select v49, v73, v71 from aggJoin4694040222359492505 join aggView6734723446262181314 using(v48));
select MIN(v71) as v71,MIN(v49) as v72,MIN(v73) as v73 from aggJoin7159800393727090614;
