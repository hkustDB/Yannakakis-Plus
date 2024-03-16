create or replace view aggView2953794952902295466 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8610553410389998227 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2953794952902295466 where mk.movie_id=aggView2953794952902295466.v12;
create or replace view aggView1732347369326959438 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin5890530258547433201 as select movie_id as v12 from movie_companies as mc, aggView1732347369326959438 where mc.company_id=aggView1732347369326959438.v1;
create or replace view aggView5637111879363730312 as select v12 from aggJoin5890530258547433201 group by v12;
create or replace view aggJoin4417927233647364792 as select v18, v31 as v31 from aggJoin8610553410389998227 join aggView5637111879363730312 using(v12);
create or replace view aggView9065018712257804656 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2550915434621517877 as select v31 from aggJoin4417927233647364792 join aggView9065018712257804656 using(v18);
select MIN(v31) as v31 from aggJoin2550915434621517877;
