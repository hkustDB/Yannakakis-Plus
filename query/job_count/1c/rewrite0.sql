create or replace view aggView5684094773498975624 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin771146560012709793 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5684094773498975624 where mc.company_type_id=aggView5684094773498975624.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5760412797855515604 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6657147799639152244 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5760412797855515604 where mi_idx.info_type_id=aggView5760412797855515604.v3;
create or replace view aggView7430557941648079082 as select v15, COUNT(*) as annot from aggJoin6657147799639152244 group by v15;
create or replace view aggJoin5095276242859738736 as select id as v15, production_year as v19, annot from title as t, aggView7430557941648079082 where t.id=aggView7430557941648079082.v15 and production_year>2010;
create or replace view aggView6607003324626288337 as select v15, SUM(annot) as annot from aggJoin5095276242859738736 group by v15;
create or replace view aggJoin3153963903523577492 as select annot from aggJoin771146560012709793 join aggView6607003324626288337 using(v15);
select SUM(annot) as v27 from aggJoin3153963903523577492;
