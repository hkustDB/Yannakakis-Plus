create or replace view aggView3678545178246788159 as select name as v36, id as v35 from name as n where name LIKE '%An%' and gender= 'f';
create or replace view aggView6652264864454492854 as select person_id as v35, name as v3 from aka_name as an group by person_id,name;
create or replace view aggView5060384891026590610 as select name as v10, id as v9 from char_name as chn;
create or replace view aggJoin557601647026800026 as (
with aggView558383236400916396 as (select id as v32 from company_name as cn where country_code= '[us]')
select movie_id as v18 from movie_companies as mc, aggView558383236400916396 where mc.company_id=aggView558383236400916396.v32);
create or replace view aggJoin6465206900973918008 as (
with aggView5821592159520278325 as (select v18 from aggJoin557601647026800026 group by v18)
select id as v18, title as v47 from title as t, aggView5821592159520278325 where t.id=aggView5821592159520278325.v18);
create or replace view aggView7467604667967660975 as select v18, v47 from aggJoin6465206900973918008 group by v18,v47;
create or replace view aggJoin1701210443471404862 as (
with aggView6621553217923869468 as (select v35, MIN(v36) as v60 from aggView3678545178246788159 group by v35)
select person_id as v35, movie_id as v18, person_role_id as v9, note as v20, role_id as v22, v60 from cast_info as ci, aggView6621553217923869468 where ci.person_id=aggView6621553217923869468.v35 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)'));
create or replace view aggJoin838310631373324376 as (
with aggView6388119786033727550 as (select v35, MIN(v3) as v58 from aggView6652264864454492854 group by v35)
select v18, v9, v20, v22, v60 as v60, v58 from aggJoin1701210443471404862 join aggView6388119786033727550 using(v35));
create or replace view aggJoin4635471990056978813 as (
with aggView7435603610413110407 as (select v18, MIN(v47) as v61 from aggView7467604667967660975 group by v18)
select v9, v20, v22, v60 as v60, v58 as v58, v61 from aggJoin838310631373324376 join aggView7435603610413110407 using(v18));
create or replace view aggJoin7155677421910772925 as (
with aggView9149599132599302627 as (select id as v22 from role_type as rt where role= 'actress')
select v9, v20, v60, v58, v61 from aggJoin4635471990056978813 join aggView9149599132599302627 using(v22));
create or replace view aggJoin1540647376104868313 as (
with aggView1721159907168873058 as (select v9, MIN(v60) as v60, MIN(v58) as v58, MIN(v61) as v61 from aggJoin7155677421910772925 group by v9,v61,v60,v58)
select v10, v60, v58, v61 from aggView5060384891026590610 join aggView1721159907168873058 using(v9));
select MIN(v58) as v58,MIN(v10) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1540647376104868313;
