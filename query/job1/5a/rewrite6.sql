create or replace view aggView7872840029638075782 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2191311990183324075 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7872840029638075782 where mc.company_type_id=aggView7872840029638075782.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView5503027491869137572 as select v15 from aggJoin2191311990183324075 group by v15;
create or replace view aggJoin614843576463343632 as select id as v15, title as v16 from title as t, aggView5503027491869137572 where t.id=aggView5503027491869137572.v15 and production_year>2005;
create or replace view aggView4967951014588434919 as select id as v3 from info_type as it;
create or replace view aggJoin8635972555150458271 as select movie_id as v15 from movie_info as mi, aggView4967951014588434919 where mi.info_type_id=aggView4967951014588434919.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5060683097088533669 as select v15 from aggJoin8635972555150458271 group by v15;
create or replace view aggJoin8940518516037263043 as select v16 from aggJoin614843576463343632 join aggView5060683097088533669 using(v15);
select MIN(v16) as v27 from aggJoin8940518516037263043;
