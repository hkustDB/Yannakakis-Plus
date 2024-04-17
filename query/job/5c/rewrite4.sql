create or replace view aggView5584524196392895230 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin2974650658303650824 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView5584524196392895230 where mc.movie_id=aggView5584524196392895230.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView4705207091689039379 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4330983169485259677 as select v15, v9, v27 from aggJoin2974650658303650824 join aggView4705207091689039379 using(v1);
create or replace view aggView2416129292777373715 as select v15, MIN(v27) as v27 from aggJoin4330983169485259677 group by v15,v27;
create or replace view aggJoin7084887690074641706 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView2416129292777373715 where mi.movie_id=aggView2416129292777373715.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3990263122696533342 as select id as v3 from info_type as it;
create or replace view aggJoin3754503557856264729 as select v27 from aggJoin7084887690074641706 join aggView3990263122696533342 using(v3);
select MIN(v27) as v27 from aggJoin3754503557856264729;
