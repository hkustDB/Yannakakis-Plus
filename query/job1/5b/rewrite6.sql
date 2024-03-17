create or replace view aggView4095070508313052752 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin5129963689627441079 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4095070508313052752 where mi.movie_id=aggView4095070508313052752.v15 and info IN ('USA','America');
create or replace view aggView2922545144978334737 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5516280368283551301 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2922545144978334737 where mc.company_type_id=aggView2922545144978334737.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView8646795896666489892 as select v15 from aggJoin5516280368283551301 group by v15;
create or replace view aggJoin4645940168381624959 as select v3, v13, v27 as v27 from aggJoin5129963689627441079 join aggView8646795896666489892 using(v15);
create or replace view aggView7752614492685021909 as select v3, MIN(v27) as v27 from aggJoin4645940168381624959 group by v3;
create or replace view aggJoin3507799415693473 as select v27 from info_type as it, aggView7752614492685021909 where it.id=aggView7752614492685021909.v3;
select MIN(v27) as v27 from aggJoin3507799415693473;
