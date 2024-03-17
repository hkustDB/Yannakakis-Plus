create or replace view aggView2447953773175325061 as select id as v12, title as v31 from title as t;
create or replace view aggJoin347191352491564635 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2447953773175325061 where mk.movie_id=aggView2447953773175325061.v12;
create or replace view aggView779521373114716491 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin4393516740411738043 as select movie_id as v12 from movie_companies as mc, aggView779521373114716491 where mc.company_id=aggView779521373114716491.v1;
create or replace view aggView8353033986975485315 as select v12 from aggJoin4393516740411738043 group by v12;
create or replace view aggJoin8358278089448914713 as select v18, v31 as v31 from aggJoin347191352491564635 join aggView8353033986975485315 using(v12);
create or replace view aggView5000299386387207891 as select v18, MIN(v31) as v31 from aggJoin8358278089448914713 group by v18;
create or replace view aggJoin5103857994095247745 as select keyword as v9, v31 from keyword as k, aggView5000299386387207891 where k.id=aggView5000299386387207891.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin5103857994095247745;
