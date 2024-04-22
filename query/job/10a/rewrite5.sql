create or replace view aggJoin5553245834587233417 as (
with aggView3091644028481206760 as (select id as v31, title as v44 from title as t where production_year>2005)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView3091644028481206760 where ci.movie_id=aggView3091644028481206760.v31 and note LIKE '%(voice)%' and note LIKE '%(uncredited)%');
create or replace view aggJoin1709375324229407687 as (
with aggView7873440205278422618 as (select id as v1, name as v43 from char_name as chn)
select v31, v12, v29, v44, v43 from aggJoin5553245834587233417 join aggView7873440205278422618 using(v1));
create or replace view aggJoin5241835140532504491 as (
with aggView6130369915475722888 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v44, v43 from aggJoin1709375324229407687 join aggView6130369915475722888 using(v29));
create or replace view aggJoin284327717819644040 as (
with aggView5576592820069825896 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView5576592820069825896 where mc.company_type_id=aggView5576592820069825896.v22);
create or replace view aggJoin1400830120785439088 as (
with aggView5981081744363519691 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin284327717819644040 join aggView5981081744363519691 using(v15));
create or replace view aggJoin6237950069219926936 as (
with aggView7032386447369648100 as (select v31, MIN(v44) as v44, MIN(v43) as v43 from aggJoin5241835140532504491 group by v31,v44,v43)
select v44, v43 from aggJoin1400830120785439088 join aggView7032386447369648100 using(v31));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin6237950069219926936;
