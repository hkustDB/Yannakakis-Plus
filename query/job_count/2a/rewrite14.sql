create or replace view aggView1766922724019984723 as select id as v12 from title as t;
create or replace view aggJoin7028810193550037601 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView1766922724019984723 where mc.movie_id=aggView1766922724019984723.v12;
create or replace view aggView1637435260324008450 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin1907610954050438196 as select v12 from aggJoin7028810193550037601 join aggView1637435260324008450 using(v1);
create or replace view aggView8690544991582335405 as select v12, COUNT(*) as annot from aggJoin1907610954050438196 group by v12;
create or replace view aggJoin4851690704396803324 as select keyword_id as v18, annot from movie_keyword as mk, aggView8690544991582335405 where mk.movie_id=aggView8690544991582335405.v12;
create or replace view aggView5041691688921219605 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5382555291983204003 as select annot from aggJoin4851690704396803324 join aggView5041691688921219605 using(v18);
select SUM(annot) as v31 from aggJoin5382555291983204003;
