create or replace view aggView6991080560287106456 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin7521355506032957929 as select movie_id as v12 from movie_companies as mc, aggView6991080560287106456 where mc.company_id=aggView6991080560287106456.v1;
create or replace view aggView1378429944825407707 as select v12 from aggJoin7521355506032957929 group by v12;
create or replace view aggJoin3002577222064818581 as select id as v12, title as v20 from title as t, aggView1378429944825407707 where t.id=aggView1378429944825407707.v12;
create or replace view aggView5145649096630286999 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2348509648372851100 as select movie_id as v12 from movie_keyword as mk, aggView5145649096630286999 where mk.keyword_id=aggView5145649096630286999.v18;
create or replace view aggView1237405812468196392 as select v12, MIN(v20) as v31 from aggJoin3002577222064818581 group by v12;
create or replace view aggJoin5272313673160839333 as select v31 from aggJoin2348509648372851100 join aggView1237405812468196392 using(v12);
select MIN(v31) as v31 from aggJoin5272313673160839333;
