create or replace view aggView5879019157420428443 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2891372953942502593 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5879019157420428443 where mc.company_type_id=aggView5879019157420428443.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView2289004884003371278 as select v15 from aggJoin2891372953942502593 group by v15;
create or replace view aggJoin2943271259946190997 as select id as v15, title as v16, production_year as v19 from title as t, aggView2289004884003371278 where t.id=aggView2289004884003371278.v15 and production_year>2005;
create or replace view aggView3306531853314817500 as select id as v3 from info_type as it;
create or replace view aggJoin7813189892699873041 as select movie_id as v15, info as v13 from movie_info as mi, aggView3306531853314817500 where mi.info_type_id=aggView3306531853314817500.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2131644159266818451 as select v15 from aggJoin7813189892699873041 group by v15;
create or replace view aggJoin8748137438331525064 as select v16 from aggJoin2943271259946190997 join aggView2131644159266818451 using(v15);
select MIN(v16) as v27 from aggJoin8748137438331525064;
