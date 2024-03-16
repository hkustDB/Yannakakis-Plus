create or replace view aggView1834424174184551775 as select id as v12, title as v31 from title as t;
create or replace view aggJoin751344114083512971 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1834424174184551775 where mk.movie_id=aggView1834424174184551775.v12;
create or replace view aggView1674620887151679275 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1957878409486272783 as select v12, v31 from aggJoin751344114083512971 join aggView1674620887151679275 using(v18);
create or replace view aggView5898272591485886641 as select v12, MIN(v31) as v31 from aggJoin1957878409486272783 group by v12;
create or replace view aggJoin6113376596442724709 as select company_id as v1, v31 from movie_companies as mc, aggView5898272591485886641 where mc.movie_id=aggView5898272591485886641.v12;
create or replace view aggView2505136589413692929 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2787631541054005663 as select v31 from aggJoin6113376596442724709 join aggView2505136589413692929 using(v1);
select MIN(v31) as v31 from aggJoin2787631541054005663;
