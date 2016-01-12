package com.allinfnt.idc.common.utils.excel;

import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.jxls.util.Util;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataValidation;
import org.apache.poi.ss.usermodel.DataValidationConstraint;
import org.apache.poi.ss.usermodel.DataValidationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;

import com.allinfnt.idc.modules.sys.entity.Dict;

/**
 * POI操作Excel工具类，适用于.xls和.xlsx
 * @author Administrator
 *
 */
public class POIExcelUtil {
	/*public static void main(String[] args) {
		try {
			FileInputStream in = new FileInputStream(new File("c:\\核心路由器.xlsx"));
			List<List<Object>> list = readExcel(in, 0, 1, 0);
			for (int i = 0; i < list.size(); i++) {
				List<Object> success = list.get(i);
				System.err.println(success);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}*/
	/**
	 * 读取上传的Excel，.xls和.xlsx都适用
	 * @param inputStream
	 * 			FileInputStream 文件输入流
	 * @param readsheet
	 * 			读取第几个sheet页
	 * @param startRow
	 * 			从哪行开始读取
	 * @param startCol
	 * 			从哪列开始读取
	 * @return
	 */
	public static List<List<Object>> readExcel(InputStream inputStream,
			int readsheet, int startRow, int startCol){
		return readUploadExcel(inputStream, readsheet, startRow,startCol);
	}
	
	/**
	 * 读取excle数据
	 * 
	 * @param inputStream
	 * @param readsheet
	 *            读取第几个sheet页
	 * @param startRow
	 *            开始行
	 * @param startCol
	 *            开始列
	 * @return
	 */
	public static List<List<Object>> readUploadExcel(InputStream inputStream,
			int readsheet, int startRow, int startCol) {
		List<List<Object>> list = new ArrayList<List<Object>>();
		Workbook wb = null;
		Sheet sheet = null;
		int rows = 0;
		int cols = 0;
		try {
			// 得到excle文件路径
			wb = WorkbookFactory.create(inputStream);
			if (readsheet > wb.getNumberOfSheets() - 1) {
				return list;
			}
			// 得到当前要读的页0
			sheet = wb.getSheetAt((short) readsheet);
			rows = sheet.getLastRowNum();// 获取当前sheet页的最大行
			if (sheet.getRow(0) == null) {
				return list;
			}
			cols = sheet.getRow(0).getLastCellNum();// 获取最大列数
			// 从0开始
			if (startRow < 0)
				startRow = 0;
			if (startCol < 0)
				startCol = 0;
			// 读最后一行一列吧
			if (startRow > rows)
				startRow = rows;
			if (startCol > cols - 1)
				startCol = cols - 1;
			List<Object> rowList = null;
			for (int i = startRow; i <= rows; i++) {
				rowList = new ArrayList<Object>();
				Row row = sheet.getRow(i);// 循环获取各行
				if (row == null) {
					continue;
				}
				int sum = 0;
				for (int j = startCol; j < cols; j++) {
					/** 判断时候存在合并单元格. */
					boolean isMergedRegion = isMergedRegion(sheet, i, j);
					if (isMergedRegion == true) {
						/** 获取单元格的值. */
						Cell getMergedRegionValue = getMergedRegionValue(sheet,
								i, j);
						String getCellValue = getCellValue(getMergedRegionValue);
						rowList.add(getCellValue);
					} else {
						// 非合并单元格的读取方法
						Cell cell = row.getCell(j);
						if (cell == null
								|| cell.getCellType() == Cell.CELL_TYPE_BLANK) {
							rowList.add("");
							sum++;
							continue;
						}
						Object cellValue = null;
						/** 获取单元格的值. */
						cellValue = getCellValue(cell);
						rowList.add(cellValue);
						if (cellValue == null) {
							sum++;
						}
					}// else
				}// 内for
				if (sum != cols) {
					// 添加该行
					list.add(rowList);
				}
			}// 外侧for

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 获取合并单元格的值
	 * 
	 * @param sheet
	 * @param row
	 * @param column
	 * @return
	 */
	public static Cell getMergedRegionValue(Sheet sheet, int row, int column) {
		int sheetMergeCount = sheet.getNumMergedRegions();
		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress ca = sheet.getMergedRegion(i);
			int firstColumn = ca.getFirstColumn();
			int lastColumn = ca.getLastColumn();
			int firstRow = ca.getFirstRow();
			int lastRow = ca.getLastRow();
			if (row >= firstRow && row <= lastRow) {
				if (column >= firstColumn && column <= lastColumn) {
					Row fRow = sheet.getRow(firstRow);
					Cell fCell = fRow.getCell(firstColumn);

					return fCell;
				}
			}
		}

		return null;
	}

	/**
	 * 判断指定的单元格是否是合并单元格
	 * 
	 * @param sheet
	 * @param row
	 * @param column
	 * @return
	 */
	public static boolean isMergedRegion(Sheet sheet, int row, int column) {
		// 获取合并单元格的数量
		int sheetMergeCount = sheet.getNumMergedRegions();
		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress ca = sheet.getMergedRegion(i);
			int firstColumn = ca.getFirstColumn();
			int lastColumn = ca.getLastColumn();
			int firstRow = ca.getFirstRow();
			int lastRow = ca.getLastRow();
			if (row >= firstRow && row <= lastRow) {// 存在合并单元格
				if (column >= firstColumn && column <= lastColumn) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 获取单元格的值
	 * 
	 * @param cell
	 * @return
	 */
	public static String getCellValue(Cell cell) {

		if (cell == null)
			return "";
		if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
			return cell.getStringCellValue();
		} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(cell.getBooleanCellValue());
		} else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
			return cell.getCellFormula();
		} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
				Date date = cell.getDateCellValue();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				return format.format(date);
			} else {
				BigDecimal d = new BigDecimal(cell.getNumericCellValue());
				if (new BigDecimal(d.longValue()).equals(d)) {
					return String.valueOf(d.longValue());
				} else {
					return String.valueOf(d.floatValue());
				}
			}
		}
		return "";
	}
	/**
	 * 获取单元格的值
	 * 
	 * @param cell
	 * @return
	 */
	public static String getCellValue(Row row, int column) {
		try {
			Cell cell = row.getCell(column);
			if (cell == null)
				return "";
			if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
				return cell.getStringCellValue();
			} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
				return String.valueOf(cell.getBooleanCellValue());
			} else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
				return cell.getCellFormula();
			} else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
					Date date = cell.getDateCellValue();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					return format.format(date);
				} else {
					BigDecimal d = new BigDecimal(cell.getNumericCellValue());
					if (new BigDecimal(d.longValue()).equals(d)) {
						return String.valueOf(d.longValue());
					} else {
						return String.valueOf(d.floatValue());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/**
	 * 设置单元格字体
	 * @param wb
	 * @param cellStyle
	 * @param fontSize
	 * @return
	 */
	public static CellStyle setFont(SXSSFWorkbook wb ,CellStyle cellStyle ,Short fontSize ,String fontType){
		Font f  = wb.createFont(); 
		f.setFontHeightInPoints(fontSize);//字号      
		if(fontType.equals("1")){
			f.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);//加粗
		}
		cellStyle.setFont(f);
		return cellStyle;
		
	}
	
	/**
	 * 设置单元格内容对齐
	 * @param cellStyle
	 * @return
	 */
	public static CellStyle setAlignment(CellStyle cellStyle){
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//设置对齐
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		return cellStyle;
		
	}
	
	/**
	 * 创建call
	 * @param column
	 * @param callValue
	 * @param row
	 * @return
	 */
	public static Cell createCell(int column ,String callValue ,Row row ,CellStyle cellStyle){
		Cell cell = row.createCell(column);
		cell.setCellValue(callValue);
		cell.setCellStyle(cellStyle);
		return cell;
		
	}
	
	/**
	 * 设置excel下拉框选项
	 * @param dictList
	 * @param sheet
	 * @param beginRow
	 * @param beginCol
	 * @param endRow
	 * @param endCol
	 */
	public static void setValidationData(List<Dict> dictList ,Sheet sheet ,int beginRow,int beginCol,int endRow,int endCol){
		
		DataValidationHelper dvHelper = sheet.getDataValidationHelper();
		Object[] diceValue = dictList.toArray();
		String[] textlist = new String[diceValue.length];
		for(int i=0;i<diceValue.length;i++){
			textlist[i] = diceValue[i].toString();
		}
		
		DataValidationConstraint dvConstraint = dvHelper
				.createExplicitListConstraint(textlist);
		CellRangeAddressList addressList = new CellRangeAddressList(
				beginRow, beginCol, endRow, endCol);
		DataValidation validation = dvHelper.createValidation(
				dvConstraint, addressList);
		if (validation instanceof XSSFDataValidation) {
			validation.setSuppressDropDownArrow(true);
			validation.setShowErrorBox(true);
		}
		sheet.addValidationData(validation);
	}
	
	public static void insertRow(HSSFSheet sheet, int startRow, int rows) {

		sheet.shiftRows(startRow + 1, sheet.getLastRowNum(), rows, true, false);
		// Parameters:
		// startRow - the row to start shifting
		// endRow - the row to end shifting
		// n - the number of rows to shift
		// copyRowHeight - whether to copy the row height during the shift
		// resetOriginalRowHeight - whether to set the original row's height to
		// the default

		for (int i = 0; i < rows; i++) {

			HSSFRow sourceRow = null;
			HSSFRow targetRow = null;

			sourceRow = sheet.getRow(startRow);
			targetRow = sheet.createRow(++startRow);

			Util.copyRow(sheet, sourceRow, targetRow);
		}

	}
}
