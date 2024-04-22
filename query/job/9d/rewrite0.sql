create or replace view aggView1869338009693292855 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView4743613990576448267 as select id as v9, name as v10 from char_name as chn;
create or replace view aggView3397478506428075425 as select name as v36, id as v35 from name as n where gender= 'f';
create or replace view aggJoin6101188830132289006 as (
with aggView8833226577397901244 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView8833226577397901244 where mc.company_id=aggView8833226577397901244.v32);
create or replace view aggJoin8822303068493630050 as (
with aggView2590724558053261311 as (select v18 from aggJoin6101188830132289006 group by v18)
select id as v18, title as v47 from title as t, aggView2590724558053261311 where t.id=aggView2590724558053261311.v18);
create or replace view aggView2257849547980797173 as select v18, v47 from aggJoin8822303068493630050 group by v18,v47;
create or replace view aggJoin9187436711771583921 as (
with aggView1898062994863418121 as (select v9, MIN(v10) as v59 from aggView4743613990576448267 group by v9)
select person_id as v35, movie_id as v18, note as v20, role_id as v22, v59 from cast_info as ci, aggView1898062994863418121 where ci.person_role_id=aggView1898062994863418121.v9 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin3714435168652621918 as (
with aggView999442983607418340 as (select v18, MIN(v47) as v61 from aggView2257849547980797173 group by v18)
select v35, v20, v22, v59 as v59, v61 from aggJoin9187436711771583921 join aggView999442983607418340 using(v18));
create or replace view aggJoin5071611724408296566 as (
with aggView8162265226230575430 as (select v35, MIN(v3) as v58 from aggView1869338009693292855 group by v35)
select v36, v35, v58 from aggView3397478506428075425 join aggView8162265226230575430 using(v35));
create or replace view aggJoin4632390217520615851 as (
with aggView1184821695357832031 as (select id as v22 from role_type as rt where role= 'actress')
select v35, v20, v59, v61 from aggJoin3714435168652621918 join aggView1184821695357832031 using(v22));
create or replace view aggJoin3988756175233148683 as (
with aggView4238016230564922972 as (select v35, MIN(v59) as v59, MIN(v61) as v61 from aggJoin4632390217520615851 group by v35,v59,v61)
select v36, v58 as v58, v59, v61 from aggJoin5071611724408296566 join aggView4238016230564922972 using(v35));
select MIN(v58) as v58,MIN(v59) as v59,MIN(v36) as v60,MIN(v61) as v61 from aggJoin3988756175233148683;
