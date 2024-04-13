create or replace view aggView1763168730106863810 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6076206526723431119 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1763168730106863810 where mk.movie_id=aggView1763168730106863810.v12;
create or replace view aggView6598807060702370899 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin8025843259375477314 as select movie_id as v12 from movie_companies as mc, aggView6598807060702370899 where mc.company_id=aggView6598807060702370899.v1;
create or replace view aggView5988876622739365245 as select v12 from aggJoin8025843259375477314 group by v12;
create or replace view aggJoin960555105505491556 as select v18, v31 as v31 from aggJoin6076206526723431119 join aggView5988876622739365245 using(v12);
create or replace view aggView2299106095177003165 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1191970770163236747 as select v31 from aggJoin960555105505491556 join aggView2299106095177003165 using(v18);
select MIN(v31) as v31 from aggJoin1191970770163236747;
