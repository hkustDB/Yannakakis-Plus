create or replace view aggView8318569174971988827 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2667976248092811118 as select movie_id as v15 from movie_info_idx as mi_idx, aggView8318569174971988827 where mi_idx.info_type_id=aggView8318569174971988827.v3;
create or replace view aggView7216956464297562866 as select v15, COUNT(*) as annot from aggJoin2667976248092811118 group by v15;
create or replace view aggJoin1210361105774625675 as select id as v15, production_year as v19, annot from title as t, aggView7216956464297562866 where t.id=aggView7216956464297562866.v15 and production_year>2000;
create or replace view aggView2231474159389803375 as select v15, SUM(annot) as annot from aggJoin1210361105774625675 group by v15;
create or replace view aggJoin6080747600243552209 as select company_type_id as v1, note as v9, annot from movie_companies as mc, aggView2231474159389803375 where mc.movie_id=aggView2231474159389803375.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8237739724088404964 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5555435608490004223 as select annot from aggJoin6080747600243552209 join aggView8237739724088404964 using(v1);
select SUM(annot) as v27 from aggJoin5555435608490004223;
